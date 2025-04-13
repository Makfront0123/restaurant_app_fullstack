import mongoose from "mongoose";
// models/user_model.js
const userSchema = new mongoose.Schema({
    name: String,
    email: String,
    password: String,
    phone: String,
    address: String,
    favorites: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Products' }],
    cart: [{ item: { type: mongoose.Schema.Types.ObjectId, ref: 'Products' }, quantity: Number }],
    role: { type: String, enum: ['customer', 'admin'], default: 'customer' }
});


export default mongoose.model('User', userSchema);