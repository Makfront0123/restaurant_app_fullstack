import Auth from "../models/auth_model.js";

export const getUser = async (req, res) => {
    const { id } = req.params;
    try {
        const user = await Auth.findById(id);
        if (!user) return res.status(404).json({ message: "User not found" });
        res.status(200).json({ message: "User found", data: user });
    } catch (error) {
        res.status(500).json({ message: "Internal server error", error });
    }
}