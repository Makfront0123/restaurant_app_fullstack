import express from 'express';
import { authRegister ,authLogin ,authLogout ,authVerify ,authForgotPassword ,authResetPassword } from '../controllers/auth_controller.js';

const router= express.Router();

router.post('/register',authRegister)
router.post('/login',authLogin)
router.get('/logout',authLogout)
router.post('/verify',authVerify)
router.post('/forgot-password',authForgotPassword)
router.post('/reset-password',authResetPassword)


export default router;