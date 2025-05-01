import Auth from "../models/auth_model.js";
import bcrypt from "bcryptjs";
import asyncHandler from "express-async-handler";

export const getUser = asyncHandler(async (req, res) => {
    const { id } = req.params;
    try {
        const user = await Auth.findById(id);
        if (!user) return res.status(404).json({ message: "User not found" });
        res.status(200).json({ message: "User found", data: user });
    } catch (error) {
        res.status(500).json({ message: "Internal server error", error });
    }
})


export const editUser = asyncHandler(async (req, res) => {
  const { name, password, confirmPassword } = req.body;
  const image = req.file;

  try {
    const user = await Auth.findById(req.user.id);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    if (password) {
      if (password !== confirmPassword) {
        return res.status(400).json({ message: "Password and confirm password must match" });
      }
      user.password = password;
    }

    if (name) {
      user.name = name;
    }

    if (image) {
      user.imageUser = `/uploads/${image.filename}`;
    }

    await user.save();

    res.status(200).json({ message: "User updated successfully", data: user });
  } catch (error) {
    res.status(500).json({ message: "Internal server error", error: error.message });
  }
});
