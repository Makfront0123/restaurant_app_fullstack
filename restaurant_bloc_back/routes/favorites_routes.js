import express from 'express';
import authMiddleware from '../middlewares/auth_middleware.js'
const router = express.Router();

router.post('/add-favorite', authMiddleware, favoriteCreate)
router.post('/all-favorite', authMiddleware, favoriteCreate)
router.post('/removeProduct-favorite', authMiddleware, favoriteDeleteProduct)
router.delete('/clear-favorite', authMiddleware, favoriteDeleteAll)



export default router;