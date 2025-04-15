import mongoose from 'mongoose';

const productSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    price: {
        type: Number,
        required: true,
    },
    image: {
        type: String,
        required: true,
    },
    category: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Category',
        required: false,
    },
    productWeight: {
        type: Number,
        required: true,
    },
    dateAdded: {
        type: Date,
        default: Date.now,
    },
    reviews: [
        {
            author: {
                type: String,
                required: true
            },

            comment: {
                type: String,
                required: true
            }
        }
    ]

});

 
export default mongoose.model('Product', productSchema);