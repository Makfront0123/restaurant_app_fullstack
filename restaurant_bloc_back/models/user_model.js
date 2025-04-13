
// models/user_model.js
const UserSchema = new mongoose.Schema({
    name: String,
    email: String,
    password: String,
    phone: String,
    address: String,
    favorites: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Products' }],
    cart: [{ item: { type: mongoose.Schema.Types.ObjectId, ref: 'Products' }, quantity: Number }],
    role: { type: String, enum: ['customer', 'admin'], default: 'customer' }
});
