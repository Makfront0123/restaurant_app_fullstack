export default function vefiryToken(req,res,next){
    const token = req.cookies.token || req.header('Authorization')?.replace('Bearer ', '')
    if(!token){
        return res.status(401).json({
            message:"No token provided"
        })
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded;
        next();
    } catch (error) {
        res.clearCookie('token', { httpOnly: true, secure: process.env.NODE_ENV === 'production' });
        return res.status(401).json({ message: 'Token expired or invalid, please log in again.' });
    }
}