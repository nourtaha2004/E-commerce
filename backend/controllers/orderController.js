/* eslint-disable camelcase */
/* eslint-disable no-await-in-loop */
const AppError = require('../utils/appError');
const { pool } = require('../DBConnection');

function extractDate(dateString) {
  const dateRegex = /^(\d{4}-\d{2}-\d{2})/;
  const match = dateString.match(dateRegex);
  if (match && match[1]) {
    return match[1];
  }
  return '';
}

exports.getAllOrders = async (req, res, next) => {
  try {
    const [orders] = await pool.query('CALL getAllOrders()');

    res.status(200).json({
      data: orders,
    });
  } catch (err) {
    return next(new AppError('Error fetching orders', 500));
  }
};

exports.createOrder = async (req, res, next) => {
  try {
    const {
      city,
      street,
      phone_number,
      appartment,
      card_number,
      expiration_date,
      cardholder_name,
      cvv,
    } = req.body;
    const date = extractDate(expiration_date);
    const userId = req.user.user_id;
    const insertQuery = 'CALL createOrder(?, ? , ? , ? , ? , ?,?,?,?)';
    const values = [
      userId,
      city,
      street,
      phone_number,
      appartment,
      card_number,
      date,
      cardholder_name,
      cvv,
    ];

    await pool.query(insertQuery, values);
    res.status(201).json({
      message: 'Order created waiting for admin confirmaton',
    });
  } catch (err) {
    return next(new AppError(err.message, 500));
  }
};

exports.deleteOrder = async (req, res, next) => {
  const orderId = req.params.id;

  const deleteQuery = 'CALL DeleteOrderById(?)';

  await pool.query(deleteQuery, [orderId]);

  res.status(201).json({
    message: `Order ${orderId} Deleted`,
  });
};

exports.confirmOrder = async (req, res, next) => {
  try {
    const { id } = req.params;
    const updateQuery = 'CALL fulfillOrder(?);';

    const [result] = await pool.query(updateQuery, [id]);
    const changed = result.changedRows;

    if (changed === 1) {
      res.status(200).json({
        message: 'Order Confirmed',
      });
    } else {
      return next(new AppError('Order already confirmed', 500));
    }
  } catch (err) {
    return next(new AppError('Order Cannot be confirmed', 500));
  }
};

exports.getUserOrders = async (req, res, next) => {
  try {
    const userId = req.user.user_id;
    const selectQuery = `
      SELECT  o.user_id,p.product_id,p.name,p.price,p.slug, o.order_id,o.total_price, o.fulfilled, o.order_date, od.quantity
      FROM product p, orders o, order_details od
      WHERE p.product_id = od.product_id and od.order_id = o.order_id and user_id = ?
    `;
    const [orders] = await pool.query(selectQuery, [userId]);

    if (orders.length === 0) {
      return next(new AppError('No Orders', 404));
    }

    res.status(200).json({
      data: orders,
    });
  } catch (err) {
    return next(new AppError('Error fetching orders', 500));
  }
};
