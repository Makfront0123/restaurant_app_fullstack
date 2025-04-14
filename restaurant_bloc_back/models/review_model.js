import mongoose from 'mongoose';

const reviewSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    productId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Product',
        required: true,
    },
    author: {
        type: String,
        required: true,
    },
    comment: {
        type: String,
        required: true,
    },
});

export default mongoose.model('Review', reviewSchema);