import express from 'express';
import { createReview ,getReview,deleteReview,getAllReviews,editReview} from '../controllers/reviews_controller.js';
import { authMiddleware } from '../middlewares/auth_middleware.js';
const router = express.Router();

router.post('/create-review/:productId', authMiddleware, createReview)
router.get('/get-review/:id', authMiddleware, getReview)
router.delete('/delete-review/:id', authMiddleware, deleteReview)
router.get('/all-reviews' , getAllReviews)
router.put('/edit-review/:id', authMiddleware, editReview)  

export default router;