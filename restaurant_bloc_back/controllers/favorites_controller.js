import Favorites from '../models/favorites_model.js';
import asyncHandler from 'express-async-handler';

export const addFavorite = asyncHandler(async (req, res) => {
    const { productId } = req.params;

    try {
        let favorites = await Favorites.findOne({ userId: req.user.id });

        
        if (!favorites) {
            favorites = new Favorites({
                userId: req.user.id,
                items: [{ productId }],
            });
        } else {
          
            const alreadyFavorite = favorites.items.some(
                item => item.productId.toString() === productId
            );

            if (alreadyFavorite) {
                return res.status(400).json({ message: 'Product already in favorites' });
            }

            
            favorites.items.push({ productId });
        }

        await favorites.save();

        res.status(200).json({
            message: 'Product added to favorites',
            data: favorites
        });

    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
});

export const deleteFavorite = asyncHandler(async (req, res) => {
    const { productId } = req.params;

    try {
        const favorites = await Favorites.findOne({ userId: req.user.id });

        if (!favorites) {
            return res.status(404).json({ message: 'Favorites not found' });
        }

        const productExists = favorites.items.find(
            item => item.productId.toString() === productId
        );

        if (!productExists) {
            return res.status(404).json({ message: 'Product not found in favorites' });
        }

        favorites.items = favorites.items.filter(
            item => item.productId.toString() !== productId
        );

        await favorites.save();

        res.status(200).json({ message: 'Product removed from favorites', data: favorites });
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
});

export const getFavorites = asyncHandler(async (req,res)=>{
    const favorites = await Favorites.findOne({ userId: req.user.id });
    if (!favorites) {
        return res.status(404).json({ message: 'Favorites not found' });
    }
    res.status(200).json({ message: 'Favorites found', data: favorites });
});