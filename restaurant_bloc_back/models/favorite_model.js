const favoriteSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Users',
        required: true,
    },
    items: [{ item: { type: mongoose.Schema.Types.ObjectId, ref: 'Products' }, quantity: Number }],
});

export default mongoose.model('Favorites', favoriteSchema);