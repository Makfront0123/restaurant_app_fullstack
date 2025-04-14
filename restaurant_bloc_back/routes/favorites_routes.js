import express from 'express';
import { addFavorite ,deleteFavorite } from '../controllers/favorites_controller.js';
import { authMiddleware } from '../middlewares/auth_middleware.js';
const router = express.Router();

router.post('/add-favorite/:productId', authMiddleware, addFavorite)
router.delete('/delete-favorite/:productId', authMiddleware, deleteFavorite)

export default router;