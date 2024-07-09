const { pool } = require('../DBConnection');
const AppError = require('../utils/appError');

exports.getCart = async (req, res, next) => {
  try {
    const userId = req.user.user_id;
    const selectQuery = 'CALL GetCartByUserId(?);';
    const [result] = await pool.query(selectQuery, [userId]);

    if (result.length === 0) {
      res.status(404).json({
        messgae: 'Cart not Found',
      });
    }

    res.status(200).json({
      result,
    });
  } catch (err) {
    return next(new AppError(`Cant get Cart ${err}`, 500));
  }
};

exports.addToCart = async (req, res, next) => {
  try {
    const { productId, quantity } = req.body;
    const userId = req.user.user_id;

    const query = 'CALL addToCart(?,?,?);';
    const [result] = await pool.query(query, [userId, productId, quantity]);

    if (result.affectedRows === 0) {
      return next(new AppError('Not Added', 500));
    }

    res.status(200).json({
      message: 'Added to Cart!',
    });
  } catch (err) {
    return next(new AppError(`Not Added\n${err}`, 500));
  }
};

exports.editCart = async (req, res, next) => {
  try {
    const userId = req.user.user_id;
    const { productId, newQuantity } = req.body;
    const query = 'CALL editCart(?,?,?);';
    const [result] = await pool.query(query, [userId, productId, newQuantity]);

    if (result.affectedRows === 0) {
      return next(new AppError('Not Edited', 500));
    }

    res.status(200).json({
      message: 'Edited Cart!',
    });
  } catch (err) {
    return next(new AppError('Cannot edit cart', 500));
  }
};

exports.removeItemFromCart = async (req, res, next) => {
  try {
    const productId = req.params.id;
    const userId = req.user.user_id;
    const deleteQuery = 'DELETE FROM cart WHERE product_id = ? and user_id = ?';

    await pool.query(deleteQuery, [productId, userId]);
    res.status(200).json({
      status: 'success',
    });
  } catch (error) {
    return next(new AppError('Error', 500));
  }
};
