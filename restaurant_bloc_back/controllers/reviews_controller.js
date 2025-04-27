import Review from '../models/review_model.js';
import asyncHandler from 'express-async-handler';

export const createReview = asyncHandler(async (req, res) => {
    const { productId } = req.params;
    const { author, comment } = req.body;

    if (!author || !comment) {
        return res.status(400).json({ message: 'Author and comment are required' });
    }

    try {
        const review = new Review({
            userId: req.user.id,
            productId,
            author,
            comment
        });

        await review.save();

        res.status(201).json({
            message: 'Review created successfully',
            data: review
        });
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
});

export const getReview = asyncHandler(async (req, res) => {
    const { id } = req.params;

    try {
        const review = await Review.findById(id);
        if (!review) {
            return res.status(404).json({ message: 'Review not found' });
        }
        res.status(200).json({ message: 'Review found', data: review });
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
});

export const deleteReview = asyncHandler(async (req, res) => {
    const { id } = req.params;

    try {
        const review = await Review.findById(id);
        if (!review) {
            return res.status(404).json({ message: 'Review not found' });
        }
        if (review.userId.toString() !== req.user.id) {
            return res.status(401).json({ message: 'Unauthorized' });
        }
        await review.deleteOne();

        res.status(200).json({ message: 'Review deleted successfully' });
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
});

export const getAllReviews = asyncHandler(async (req, res) => {
    try {
        const reviews = await Review.find();

        if (!reviews) {
            return res.status(404).json({ message: 'Reviews not found' });
        }

        if (reviews.length === 0) {
            return res.status(200).json({
                message: 'No reviews found for this product',
                data:[]
            });
        }

        res.status(200).json({
            message: 'Reviews found',
            data: reviews,
        });
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error,
        });
    }
});

/*
export const getAllReviews = asyncHandler(async (req, res) => {
    try {
        const reviews = await Review.find({ productId: req.params.id });

        if (!reviews) {
            return res.status(404).json({ message: 'Reviews not found' });
        }

        if (reviews.length === 0) {
            return res.status(404).json({
                message: 'No reviews found for this product',
            });
        }

        res.status(200).json({
            message: 'Reviews found',
            data: reviews,
        });
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error,
        });
    }
});
*/
export const editReview = asyncHandler(async (req, res) => {
    const { id } = req.params;
    const { author, comment } = req.body;

    try {
        const review = await Review.findByIdAndUpdate(id, {
            author,
            comment
        });
        if (!review) {
            return res.status(404).json({ message: 'Review not found' });
        }
        res.status(200).json({ message: 'Review updated successfully', data: review });
    } catch (error) {
        res.status(500).json({
            message: 'Internal server error',
            error: error.message || error
        });
    }
});