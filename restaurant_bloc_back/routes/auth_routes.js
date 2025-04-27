import express from 'express';
import { authRegister, authLogin,getAuthenticatedUser, authLogout,verifyForgotOtp,resendForgotPasswordOtp, authVerify, authForgotPassword, resetPassword, authResendOtp } from '../controllers/auth_controller.js';
import { authMiddleware } from '../middlewares/auth_middleware.js';
const router = express.Router();

router.post('/register', authRegister)
router.post('/login', authLogin)
router.get('/logout',  authLogout)
router.post('/verify', authVerify)
router.post('/resend-otp', authResendOtp)
router.post('/resend-forgot-otp', resendForgotPasswordOtp)
router.post('/forgot-password', authForgotPassword)
router.post('/reset-password', resetPassword)
router.post('/verify-forgot', verifyForgotOtp)
router.get("/check-auth", authMiddleware, getAuthenticatedUser);


export default router;