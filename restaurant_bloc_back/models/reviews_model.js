import mongoose from "mongoose";

const reviewSchema = new mongoose.Schema({
    user:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Users',
        required: true,
    },
    product:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Products',
        required: true,
    },
    review:{
        type: String,
        required: false,
    },
    createdAt:{
        type: Date,
        default: Date.now,
    },
})

export default mongoose.model('Reviews', reviewSchema);