const express = require('express');
const cartController = require('../controllers/cartController');
const authController = require('../controllers/authController');

const router = express.Router();

router.use(authController.protect);

router.get('/', cartController.getCart);

router.post('/', cartController.addToCart);

router.patch('/', cartController.editCart);

router.delete('/remove/:id', cartController.removeItemFromCart);

module.exports = router;
