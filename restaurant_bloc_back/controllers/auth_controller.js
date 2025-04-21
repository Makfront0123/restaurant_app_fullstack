import asyncHandler from "express-async-handler"
import Auth from '../models/auth_model.js';
import jwt from 'jsonwebtoken';
import crypto from 'crypto';
import sendEmail from '../utils/send_email.js';


export const authRegister = asyncHandler(async (req, res) => {
    try {
        const { name, email, password, confirmPassword } = req.body;
        if (!name) return res.status(400).json({ message: "Name is required" });
        if (!email) return res.status(400).json({ message: "Email is required" });
        if (!password) return res.status(400).json({ message: "Password is required" });
        if (!confirmPassword) return res.status(400).json({ message: "Confirm Password is required" });
        if (password !== confirmPassword) return res.status(400).json({ message: "Password and Confirm Password must match" });

        const userExists = await Auth.findOne({ email });
        if (userExists) return res.status(404).json({
            message: "User already exists"
        })




        const otp = crypto.randomInt(100000, 999999).toString();
        const otpExpires = Date.now() + 10 * 60 * 1000;

        const user = new Auth({
            name,
            email,
            password,
            otp,
            otpExpires
        })

        await user.save();

        await sendEmail({
            to: email,
            subject: 'Verify your account',
            text: `Enter the OTP sent to your email to verify your account, ${otp}`
        })

        res.status(201).json({
            message: "User created successfully. OTP sent to email.",
            data: {
                user
            }
        });

    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        })
    }
})

export const authLogin = asyncHandler(async (req, res) => {
    const tokenVerify = req.cookies.token || req.header('Authorization')?.replace('Bearer ', '');
    if (tokenVerify) {
        return res.status(401).json({ message: 'Already logged in' });
    }
    const { email, password } = req.body;
    if (!email) return res.status(400).json({ message: "Email is required" });
    if (!password) return res.status(400).json({ message: "Password is required" });
    try {
        const user = await Auth.findOne({ email });
        if (!user) return res.status(404).json({ message: "Invalid email or password" });
        const isMatch = await user.matchPassword(password);
        if (!isMatch) return res.status(400).json({ message: "Password is incorrect" });
        const accountVerified = user.accountVerified;
        if (!accountVerified) return res.status(400).json({ message: "Account not verified" });


        const secret = `${process.env.JWT_SECRET}`;

        const payload = { userId: user._id };
        const token = jwt.sign(payload, secret, { expiresIn: '1h' });

        res.cookie('token', token, { httpOnly: true, secure: true, sameSite: 'None', });

        res.json({ message: 'Logged in successfully', data: { user, token } });
    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        })
    }
})

export const authLogout = asyncHandler(async (req, res) => {
    res.clearCookie('token', { httpOnly: true, secure: true, sameSite: 'None', });
    res.json({ message: 'Logged out successfully' });
})

export const authVerify = asyncHandler(async (req, res) => {
    const { email, otp } = req.body;

    try {
        const user = await Auth.findOne({ email });
        if (!user) return res.status(404).json({ message: "User not found" });
        if (user.accountVerified) return res.status(400).json({ message: "Account already verified" });
        if (user.otp !== otp || user.otpExpires < Date.now()) return res.status(400).json({ message: "OTP is invalid or expired" });
        user.accountVerified = true;
        user.otp = null;
        user.otpExpires = null;

        await user.save();

        res.status(200).json({ message: "Account verified successfully" });
    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        })
    }
})

export const verifyForgotOtp = asyncHandler(async (req, res) => {
    const { email, otp } = req.body;

    const user = await Auth.findOne({ email });
    if (!user) return res.status(404).json({ message: "User not found" });

    if (user.otp !== otp || user.otpExpires < Date.now()) {
        return res.status(400).json({ message: "Invalid or expired OTP" });
    }

    // Invalida el OTP
    user.otp = null;
    user.otpExpires = null;

    // Genera un token seguro para resetear la contraseña
    const resetToken = crypto.randomInt(100, 999).toString();
    user.resetPasswordToken = resetToken;
    user.resetPasswordExpires = Date.now() + 10 * 60 * 1000;

    await user.save();

    res.status(200).json({
        message: "OTP verified. Use this token to reset password.",
        data: {
            token: resetToken,
            user
        }
    });
});

export const authResendOtp = asyncHandler(async (req, res) => {
    const { email } = req.body;
    try {
        const user = await Auth.findOne({ email });
        if (!user) return res.status(404).json({ message: "User not found" });

        const otp = crypto.randomInt(100000, 999999).toString();
        const otpExpires = Date.now() + 10 * 60 * 1000;

        user.otp = otp;
        user.otpExpires = otpExpires;
        await user.save();

        await sendEmail({
            to: email,
            subject: 'Verify your account',
            text: `Enter the OTP sent to your email to verify your account, ${otp}`
        })

        res.status(200).json({ message: "OTP sent successfully" });
    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        })
    }
})

// 3 dígitos, recuperación de contraseña
export const resendForgotPasswordOtp = asyncHandler(async (req, res) => {
    const { email } = req.body;
    try {
      const user = await Auth.findOne({ email });
      if (!user) return res.status(404).json({ message: "User not found" });
  
      const otp = crypto.randomInt(100, 999).toString(); // 3 dígitos
      user.otp = otp;
      user.otpExpires = Date.now() + 10 * 60 * 1000;
  
      await user.save();
  
      await sendEmail({
        to: email,
        subject: 'Reset your password',
        text: `Enter this OTP to reset your password: ${otp}`,
      });
  
      res.status(200).json({ message: "Password reset OTP resent successfully" });
    } catch (error) {
      res.status(500).json({ message: "Internal server error", error });
    }
  });
  

export const authForgotPassword = asyncHandler(async (req, res) => {
    const { email } = req.body;
    try {
        if (!email) return res.status(400).json({ message: "Email is required" });
        const user = await Auth.findOne({ email });
        if (!user) return res.status(404).json({ message: "User not found" });

        const resetToken = crypto.randomInt(100, 999).toString();
        const resetExpires = Date.now() + 10 * 60 * 1000;

        user.otp = resetToken;
        user.otpExpires = resetExpires;
        await user.save();

        await sendEmail({
            to: email,
            subject: 'Password Reset',
            text: `Copy this otp: ${resetToken}`
        });

        res.status(200).json({
            message: 'Password reset email sent',
            data: {
                user,
                resetToken,
                resetExpires
            }
        });

    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        })
    }
})


export const resetPassword = asyncHandler(async (req, res) => {
    const { token, newPassword } = req.body;

    if (!token || !newPassword) {
        return res.status(400).json({ message: "Token and new password are required" });
    }

    const user = await Auth.findOne({
        resetPasswordToken: token,
        resetPasswordExpires: { $gt: Date.now() }
    });

    if (!user) {
        return res.status(400).json({ message: "Invalid or expired token" });
    }

    user.password = newPassword;
    user.resetPasswordToken = null;
    user.resetPasswordExpires = null;
    await user.save();

    res.status(200).json({ message: "Password successfully reset" });
});

// controllers/AuthController.js
export const getAuthenticatedUser = async (req, res) => {
    try {
      const user = req.user; // El middleware ya lo puso
  
      res.status(200).json({
        message: "User authenticated",
        data: user,
      });
    } catch (error) {
      res.status(500).json({
        message: "Internal server error",
        error,
      });
    }
  };
  