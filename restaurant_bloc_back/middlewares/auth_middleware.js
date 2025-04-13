import User from "../models/user_model.js"

export const authMiddleware =async (req,res,next) => { 
    const token = req.cookies.token || req.header('Authorization')?.replace('Bearer ', '')
    if(!token){
        return res.status(401).json({
            isAuthenticated:false,
            message:'No token provided'
        })
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const user= await User.findById(decoded.userId)
        if(!user){
            res.status(401).json({
                isAuthenticated:false,
                message:'User not found'
            })
        }
        req.user =user
        next();
    } catch (error) {
        return res.json({
            isAuthenticated: false,
            message: 'Token is invalid or expired'
        });
    }

}