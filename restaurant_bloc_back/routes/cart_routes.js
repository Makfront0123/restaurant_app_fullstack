import express from 'express';
import { addToCart, allCart ,deleteCart,clearCart, getCart } from '../controllers/cart_controller.js';
import { authMiddleware } from '../middlewares/auth_middleware.js';
const router = express.Router();

router.post('/add-cart/:productId',authMiddleware, addToCart)
router.get('/all-cart', allCart)
router.delete('/delete-cart/:productId',authMiddleware ,deleteCart)
router.delete('/clear-cart', authMiddleware,clearCart)
router.get('/get-cart', authMiddleware,getCart)

export default router;