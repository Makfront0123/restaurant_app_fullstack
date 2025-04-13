import mongoose from 'mongoose';
import bcrypt from 'bcryptjs';
const authSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    accountVerified: {
        type: Boolean,
        default: false
    },
    otp: {
        type: String
    },
    otpExpires: {
        type: Date
    },
    resetPasswordToken: {
        type: String
    },
    resetPasswordExpires: {
        type: Date
    }
    ,
    imageUser: {
        type: String,
        default: ''
    },
    favorites: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Product' }],
    cart: [
        {
            item: { type: mongoose.Schema.Types.ObjectId, ref: 'Product' },
            quantity: Number
        }
    ],


    role: {
        type: String,
        enum: ['customer', 'admin'],
        default: 'customer'
    }

})

authSchema.pre('save', async function (next) {
    if (this.isModified('password')) {
        this.password = await bcrypt.hash(this.password, 12);
    }
    next();
});

authSchema.methods.matchPassword = async function (enteredPassword) {
    return await bcrypt.compare(enteredPassword, this.password);
};

authSchema.methods.updateProfile = async function (name, email, currentPassword, newPassword, confirmPassword) {
    if (name) {
        this.name = name;
    }

    if (email) {
        this.email = email;
    }

    if (newPassword) {

        if (newPassword !== confirmPassword) {
            throw new Error('Passwords do not match');
        }


        if (currentPassword) {
            const isMatch = await this.comparePassword(currentPassword);
            if (!isMatch) {
                throw new Error('Current password is incorrect');
            }
        }


        this.password = newPassword;
    }


    await this.save();
};


export default mongoose.model('User', authSchema);