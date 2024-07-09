const jwt = require('jsonwebtoken');
const { promisify } = require('util');
const AppError = require('../utils/appError');
const { pool } = require('../DBConnection');

const signToken = (id) =>
  jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES_IN,
  });

const createSendToken = (user, statusCode, res) => {
  const token = signToken(user.user_id);
  const cookieOptions = {
    expires: new Date(
      Date.now() + process.env.JWT_COOKIE_EXPIRES_IN * 24 * 60 * 60 * 1000,
    ),
    httpOnly: true,
  };
  if (process.env.NODE_ENV === 'production') cookieOptions.secure = true;

  res.cookie('jwt', token, cookieOptions);

  // Remove password from output
  user.password = undefined;

  res.status(statusCode).json({
    status: 'success',
    token,
    data: {
      user,
    },
  });
};

exports.signup = async (req, res, next) => {
  try {
    const { firstName, lastName, username, email, password, confirmPassword } =
      req.body;
    const role = 'customer';
    const insertQuery = 'CALL register_user (?,?,?,?,?,?,?)';

    const [result] = await pool.query(insertQuery, [
      firstName,
      lastName,
      username,
      email,
      password,
      confirmPassword,
      role,
    ]);

    const newUser = {
      id: result.insertId,
      firstName,
      lastName,
      username,
      email,
      password,
      confirmPassword,
      role,
    };
    createSendToken(newUser, 201, res);
  } catch (error) {
    return next(new AppError('Eror sign up', 500));
  }
};

exports.login = async (req, res, next) => {
  try {
    const { email, password } = req.body;
    const selectQuery = 'CALL user_login (?,?);';
    const [result] = await pool.query(selectQuery, [email, password]);
    const user = result[0][0];
    // 3) If everything ok, send token to client
    createSendToken(user, 200, res);
  } catch (err) {
    return next(new AppError('Erorr login', 500));
  }
};

exports.protect = async (req, res, next) => {
  // 1) Getting token and check of it's there
  let token;
  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith('Bearer')
  ) {
    token = req.headers.authorization.split(' ')[1];
  }
  if (!token) {
    return next(
      new AppError('You are not logged in! Please log in to get access.', 401),
    );
  }
  // 2) Verification token
  const decoded = await promisify(jwt.verify)(token, process.env.JWT_SECRET);
  // 3) Check if user still exists
  const [result] = await pool.query('SELECT * FROM user WHERE user_id = ?', [
    decoded.id,
  ]);
  const currentUser = result[0];

  if (!currentUser) {
    return next(
      new AppError(
        'The user belonging to this token does no longer exist.',
        401,
      ),
    );
  }

  req.user = currentUser;
  next();
};

exports.restrictTo =
  (...roles) =>
  async (req, res, next) => {
    if (!roles.includes(req.user.role)) {
      return next(
        new AppError('You dont have permission to perfrom this action', 403),
      );
    }
    next();
  };
