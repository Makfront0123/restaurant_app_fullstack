import express from 'express';
import { addFavorite ,deleteFavorite,getFavorites } from '../controllers/favorites_controller.js';
import { authMiddleware } from '../middlewares/auth_middleware.js';
const router = express.Router();

router.post('/add-favorite/:productId', authMiddleware, addFavorite)
router.delete('/delete-favorite/:productId', authMiddleware, deleteFavorite)
router.get('/get-favorites', authMiddleware, getFavorites)

export default router;