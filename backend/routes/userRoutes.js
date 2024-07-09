const express = require('express');
const userController = require('../controllers/userController');
const authController = require('../controllers/authController');

const router = express.Router();

router.post('/signup', authController.signup);
router.post('/login', authController.login);

router
  .route('/')
  .get(userController.getAllUsers)
  .post(userController.createUser);

router.use(authController.protect);

router.get('/payment', userController.getPaymentInfo);
router.put('/payment', userController.editPaymentInfo);

router.get('/delivery', userController.getDeliveryInfo);
router.put('/delivery', userController.editDeliveryInfo);
module.exports = router;
