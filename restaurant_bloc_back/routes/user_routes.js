import express from 'express';
import { getUser, editUser } from '../controllers/user_controller.js';
import { authMiddleware } from '../middlewares/auth_middleware.js';
const router = express.Router();

router.get('/get-user', authMiddleware, getUser)
router.put('/edit-user', authMiddleware, editUser)

export default router;