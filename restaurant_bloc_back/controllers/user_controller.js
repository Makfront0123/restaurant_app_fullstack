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


export const editUser = async (req, res) => {
    const { name, password,confirmPassword } = req.body; 
    if(password !== confirmPassword) return res.status(400).json({ message: "Password and confirm password must match" });

    try {
        // Usamos req.user.id en lugar de req.params.id, porque el middleware ya ha verificado el usuario
        const user = await Auth.findByIdAndUpdate(req.user.id, { name,  password }, { new: true });

        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }

        res.status(200).json({ message: "User updated successfully", data: user });
    } catch (error) {
        res.status(500).json({ message: "Internal server error", error: error.message });
    }
};
