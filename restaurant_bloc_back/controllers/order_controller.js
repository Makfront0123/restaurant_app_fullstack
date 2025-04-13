import Order from '../models/order_model.js';
import Cart from '../models/cart_model.js';  
import asyncHandler from 'express-async-handler';

export const createOrder = asyncHandler(async (req, res) => {
    const cart = await Cart.findOne({ userId: req.user.id }).populate('items.productId');

    if (!cart || cart.items.length === 0) {
        return res.status(400).json({ message: 'Cart is empty or not found' });
    }

    let totalPrice = 0;
    const items = cart.items.map(item => {
        const price = item.productId.price;
        const subTotal = price * item.quantity;
        totalPrice += subTotal.toFixed(2);
        return {
            productId: item.productId._id,
            quantity: item.quantity
        };
    });

    try {
        const order = new Order({
            userId: req.user.id,
            items,
            status: 'pending',
            deliveryAddress: req.body.deliveryAddress,
            deliveryDate: req.body.deliveryDate || Date.now(),
            totalPrice
        });

        await order.save();

        // Vaciar el carrito
        cart.items = [];
        await cart.save();

        res.status(201).json({
            message: 'Order created successfully',
            data: order
        });
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
});

export const getOrder = asyncHandler(async (req, res) => {
    const { id } = req.params;

    try {
        const order = await Order.findById(id).populate('items.productId');
        if (!order) {
            return res.status(404).json({ message: 'Order not found' });
        }
        res.status(200).json({ message: 'Order found', data: order });
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
});

export const getAllOrders = asyncHandler(async (req, res) => {
    try {
        const orders = await Order.find().populate('items.productId');
        res.status(200).json({ message: 'Orders found', data: orders });
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
}); 

export const deleteOrder = asyncHandler(async (req, res) => {
    const { id } = req.params;

    try {
        const order = await Order.findByIdAndDelete(id);
        if (!order) {
            return res.status(404).json({ message: 'Order not found' });
        }
        res.status(200).json({ message: 'Order deleted successfully' });
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
});