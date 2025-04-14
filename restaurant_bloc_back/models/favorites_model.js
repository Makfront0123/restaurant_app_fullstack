import mongoose from 'mongoose';

const favoritesSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    items:[
        {
            productId: {
                type: mongoose.Schema.Types.ObjectId,
                ref: 'Product',
                required: true,
            },
        }
    ],
    createdAt: {
        type: Date,
        default: Date.now,
    },
});

export default mongoose.model('Favorites', favoritesSchema);