import express from 'express';
import { createOrder,getOrder,getAllOrders,deleteOrder } from '../controllers/order_controller.js';
import { authMiddleware } from '../middlewares/auth_middleware.js';
const router = express.Router();

router.post('/create-order', authMiddleware,createOrder)
router.get('/get-order/:id',authMiddleware,getOrder)
router.get('/all-orders',getAllOrders)
router.delete('/delete-order/:id',authMiddleware,deleteOrder)
/*
 
router.put('/edit-order/:id',authMiddleware,editOrder)
*/

export default router;