import mongoose from 'mongoose';

const cartSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    items: [{ productId: { type: mongoose.Schema.Types.ObjectId, ref: 'Product' }, quantity: Number }],
    status: { type: String, enum: ['pending', 'delivered', 'canceled'], default: 'pending' },
    deliveryAddress: String,
    deliveryDate: Date,
});

export default mongoose.model('Cart', cartSchema);