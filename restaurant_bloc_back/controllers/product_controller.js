import Product from '../models/product_model.js'
import asyncHandler from 'express-async-handler'


export const productCreate = asyncHandler(async (req, res) => {
    const { name, description, price, image, category } = req.body
    try {
        if (!name) return res.status(404).json('Name is required')
        if (!description) return res.status(404).json('Description is required')
        if (!price) return res.status(404).json('Price is required')
        if (!image) return res.status(404).json('Image is required')
        if (!category) return res.status(404).json('Category is required')

        const newProduct = new Product({
            name, description, price, image, category
        })

        await newProduct.save();
        res.status(201).json({
            message: 'Product Created Successfully',
            data: newProduct
        })
    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        })
    }
})




export const productGet = asyncHandler(async (req, res) => {
    const { _id } = req.body

    const product = await Product.findById(_id)
    if (!product) return res.status(404).json("Product not exist")

    res.status(200).json({
        message: 'Product found',
        data: product
    })

})
export const productDelete = asyncHandler(async (req, res) => {
    const { _id } = req.body
    try {

        const product = await Product.findByIdAndDelete(_id)
        if (!product) return res.status(404).json("Product not exist")

    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        })
    }

})
export const productEdit = asyncHandler(async (req, res) => {
    const { _id, name, description, price, image, category } = req.body
    try {
        const product = await Product.findByIdAndUpdate(_id, {
            name, description, price, image, category
        })
        if (!product) return res.status(404).json("Product not exist")



    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        })
    }
})
export const productAll = asyncHandler(async (req, res) => {
    const product = Product.find();
    res.status(201).json({
        message: 'Products Founds',
        data: product
    })
})