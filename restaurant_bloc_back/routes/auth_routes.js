import express from 'express';
import { authRegister, authLogin, authLogout,verifyForgotOtp, authVerify, authForgotPassword, resetPassword, authResendOtp } from '../controllers/auth_controller.js';

const router = express.Router();

router.post('/register', authRegister)
router.post('/login', authLogin)
router.get('/logout', authLogout)
router.post('/verify', authVerify)
router.post('/resend-otp', authResendOtp)
router.post('/forgot-password', authForgotPassword)
router.post('/reset-password', resetPassword)
router.post('/verify-forgot', verifyForgotOtp)


export default router;