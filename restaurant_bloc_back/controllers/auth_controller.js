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

        const newUser = new Auth({
            name,
            email,
            password,
            otp,
            otpExpires
        })

        await newUser.save();

        await sendEmail({
            to: email,
            subject: 'Verify your account',
            text: `Enter the OTP sent to your email to verify your account, ${otp}`
        })

        res.status(201).json({
            message: "User created successfully. OTP sent to email.",
            data: newUser
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
        if (!user) return res.status(404).json({ message: "User not found" });
        const isMatch = await user.matchPassword(password);
        if (!isMatch) return res.status(400).json({ message: "Password is incorrect" });
        const accountVerified = user.accountVerified;
        if (!accountVerified) return res.status(400).json({ message: "Account not verified" });


        const secret = `${process.env.JWT_SECRET}`;

        const payload = { userId: user._id };
        const token = jwt.sign(payload, secret, { expiresIn: '1h' });

        res.cookie('token', token, { httpOnly: true, secure: true, sameSite: 'None', });

        res.json({ message: 'Logged in successfully' });
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

export const authForgotPassword = asyncHandler(async (req, res) => {
    const { email } = req.body;
    try {
        const user = await Auth.findOne({ email });
        if (!user) return res.status(404).json({ message: "User not found" });

        const resetToken = crypto.randomBytes(32).toString('hex');
        const resetExpires = Date.now() + 10 * 60 * 1000;

        if (user.resetPasswordToken !== token || user.resetPasswordExpires < Date.now()) {
            return res.status(400).json({ message: "Invalid or expired token" });
        }

        user.password = await bcrypt.hash(newPassword, 12);

        user.resetPasswordToken = resetToken;
        user.resetPasswordExpires = resetExpires;
        await user.save();

        const resetUrl = `restaurantapp://reset-password?token=${resetToken}&email=${email}`;



        await sendEmail({
            to: email,
            subject: 'Password Reset',
            text: `Click on the link to reset your password: ${resetUrl}`
        });

        res.status(200).json({ message: 'Password reset email sent' });

    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        })
    }
})

export const authResetPassword = asyncHandler(async (req, res) => {
    const { token, password, newPassword,email } = req.body;
    const user = await Auth.findOne({
        email,
        
    })
    console.log(user);
    if (!user) return res.status(404).json({ message: "User not found" });

    if (newPassword !== password) return res.status(400).json({ message: "Passwords do not match" });

    user.password = newPassword;
    user.resetPasswordToken = undefined;
    user.resetPasswordExpires = undefined;
    await user.save();

    res.status(200).json({ message: "Password reset successfully" });
})