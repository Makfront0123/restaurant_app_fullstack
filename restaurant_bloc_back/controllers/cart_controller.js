import Cart from '../models/cart_model.js';
import asyncHandler from 'express-async-handler';

export const addToCart = asyncHandler(async (req, res) => {
    const { productId } = req.params;
    const { quantity } = req.body;

    if (isNaN(quantity) || quantity <= 0) {
        return res.status(400).json({ message: 'Invalid quantity' });
    }

    try {
        const cart = await Cart.findOne({ userId: req.user.id });

        if (!cart) {
            const newCart = new Cart({
                user: req.user.id,
                items: [{ productId, quantity }]
            });
            await newCart.save();
            return res.status(201).json({
                message: 'Cart created and item added',
                data: newCart
            });
        } else {
            const existingItem = cart.items.find(
                item => item.productId.toString() === productId
            );

            if (existingItem) {

                existingItem.quantity += quantity;
            } else {

                cart.items.push({ productId, quantity });
            }
        }
        await cart.save();

        res.status(200).json({
            message: 'Item added to cart',
            data: cart
        });

    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
});

export const allCart = asyncHandler(async (req, res) => {
    try {
        const cart = await Cart.findOne();
        if (!cart) {
            return res.status(404).json({ message: 'Cart not found' });
        }
        res.status(200).json({
            message: 'Carts found',
            data: cart
        });
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
});

export const getCart = asyncHandler(async (req, res) => {
    try {
        const cart = await Cart.findOne({ userId: req.user.id })
        if (!cart) {
            return res.status(404).json({ message: 'Cart not found' })
        }
        res.status(200).json({ message: 'Cart found', data: cart })
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
})
export const deleteCart = asyncHandler(async (req, res) => {
    const { productId } = req.params;

    try {
        const cart = await Cart.findOne({ userId: req.user.id });

        if (!cart) {
            return res.status(404).json({ message: 'Cart not found' });
        }

        const productExists = cart.items.find(item => item.productId.toString() === productId);

        if (!productExists) {
            return res.status(404).json({ message: 'Product not found in cart' });
        }

        const item = cart.items.find(item => item.productId.toString() === productId);

        cart.items = cart.items.filter(item => item.productId.toString() !== productId);

        await cart.save();

        res.status(200).json({ message: 'Item removed from cart', data: cart });
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
});
export const clearCart = asyncHandler(async (req, res) => {
    try {
        const cart = await Cart.findOne({ userId: req.user.id });

        if (!cart) {
            return res.status(404).json({ message: 'Cart not found' });
        }

        cart.items = [];
        await cart.save();

        res.status(200).json({ message: 'Cart cleared' });
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
});
