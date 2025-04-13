const orderSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Users',
        required: true,
    },
    items: [{ item: { type: mongoose.Schema.Types.ObjectId, ref: 'Products' }, quantity: Number }],
    status: { type: String, enum: ['pending', 'delivered', 'canceled'], default: 'pending' },
    deliveryAddress: String,
    deliveryDate: Date,
});

export default mongoose.model('Orders', orderSchema);