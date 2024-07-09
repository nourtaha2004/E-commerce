/* eslint-disable camelcase */
const { pool } = require('../DBConnection');
const AppError = require('../utils/appError');

exports.getAllUsers = async (req, res, next) => {
  try {
    const query = 'SELECT * FROM user';
    const [result] = await pool.query(query);
    res.status(200).json({
      data: {
        result,
      },
    });
  } catch (err) {
    return next(new AppError('Error Getting Users', 500));
  }
};

exports.getUser = async (req, res, next) => {
  const userEmail = req.params.email;
  try {
    const query = 'SELECT * FROM user WHERE email = ?';
    const [result] = await pool.query(query, [userEmail]);

    res.status(200).json({
      data: {
        result,
      },
    });
  } catch (err) {
    return next(new AppError('Error Getting User', 500));
  }
};

exports.createUser = async (req, res, next) => {
  try {
    const {
      firstName,
      lastName,
      username,
      email,
      password,
      passwordConfirm,
      role,
    } = req.body;

    const insertQuery = 'CALL register_user (?,?,?,?,?,?,?)';

    await pool.query(insertQuery, [
      firstName,
      lastName,
      username,
      email,
      password,
      passwordConfirm,
      role,
    ]);

    res.status(201).json({
      message: 'User created successfully',
      data: {
        email,
      },
    });
  } catch (err) {
    return next(new AppError('Error creating user', 500));
  }
};

exports.getPaymentInfo = async (req, res, next) => {
  const userId = req.user.user_id;
  try {
    const query = 'SELECT * FROM payment WHERE user_id = ?';
    const [result] = await pool.query(query, [userId]);
    result[0].expiration_date = result[0].expiration_date
      .toISOString()
      .slice(0, 10);
    res.status(200).json({
      result,
    });
  } catch (err) {
    return next(new AppError('Error Getting User' + err, 500));
  }
};

exports.getDeliveryInfo = async (req, res, next) => {
  const userId = req.user.user_id;
  try {
    const query = 'SELECT * FROM delivery WHERE user_id = ?';
    const [result] = await pool.query(query, [userId]);
    console.log(result);
    res.status(200).json({
      data: {
        result,
      },
    });
  } catch (err) {
    return next(new AppError('Error Getting User', 500));
  }
};

exports.editPaymentInfo = async (req, res, next) => {
  try {
    const userId = req.user.user_id;
    const { card_number, expiration_date, cardholder_name, cvv } = req.body;

    const formattedDate = expiration_date.slice(0, 10);
    const [result] = await pool.query('CALL PaymentInfo(?,?,?,?,?);', [
      userId,
      card_number,
      formattedDate,
      cardholder_name,
      cvv,
    ]);

    res.status(201).json({
      result: result[0],
    });
  } catch (error) {
    return next(new AppError(`Not Updated${error}`, 500));
  }
};

exports.editDeliveryInfo = async (req, res, next) => {
  try {
    const userId = req.user.user_id;
    const { city, street, apartment, phone_number } = req.body;

    const [result] = await pool.query('CALL DeliveryInfo(?,?,?,?,?);', [
      userId,
      city,
      street,
      phone_number,
      apartment,
    ]);
    res.status(201).json({
      status: 'success',
    });
  } catch (error) {
    return next(new AppError(`Not Updated${error}`, 500));
  }
};
// admin
/*
  Get all orders and confirm them
*/
