import jwt from 'jsonwebtoken';
import User from "../models/auth_model.js";

export const authMiddleware = async (req, res, next) => {
    const token = req.cookies.token || req.header('Authorization')?.replace('Bearer ', '');
    if (!token) {
        return res.status(401).json({
            isAuthenticated: false,
            message: 'No token provided',
        });
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET); // Verificación del token
        const user = await User.findById(decoded.userId); // Buscar al usuario usando el ID decodificado del token

        if (!user) {
            return res.status(401).json({
                isAuthenticated: false,
                message: 'User not found',
            });
        }

        req.user = user; // Guardamos el usuario autenticado en la solicitud
        next(); // Pasamos al siguiente middleware o ruta
    } catch (error) {
        return res.status(401).json({
            isAuthenticated: false,
            message: 'Token is invalid or expired',
        });
    }
};
