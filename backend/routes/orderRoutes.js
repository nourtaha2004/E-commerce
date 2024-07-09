const express = require('express');
const orderController = require('../controllers/orderController');
const authController = require('../controllers/authController');

const router = express.Router();

router.use(authController.protect);
router.route('/my-orders').post(orderController.createOrder);
router.route('/my-orders').get(orderController.getUserOrders);
router.use(authController.restrictTo('admin'));

router.get('/', orderController.getAllOrders);

router
  .route('/:id')
  .delete(orderController.deleteOrder)
  .post(orderController.confirmOrder);

module.exports = router;
