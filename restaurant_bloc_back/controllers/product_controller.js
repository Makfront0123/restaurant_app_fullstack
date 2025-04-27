import Product from '../models/product_model.js';
import asyncHandler from 'express-async-handler';
export const productCreate = asyncHandler(async (req, res) => {
    const { name, description, price, image, category, productWeight } = req.body;

    try {
        if (!name) return res.status(404).json('Name is required');
        if (!description) return res.status(404).json('Description is required');
        if (!price) return res.status(404).json('Price is required');
        if (!image) return res.status(404).json('Image is required');
        if (!category) return res.status(404).json('Category is required');
        if (!productWeight) return res.status(404).json('Product Weight is required');


        const newProduct = new Product({
            name,
            description,
            price,
            image,
            category,
            productWeight
        })

        await newProduct.save()
        return res.status(201).json(
            {
                message: "Product created successfully",
                data: newProduct
            }
        );
    } catch (error) {
        console.error("Create Product Error:", error);
        res.status(500).json({
            message: "Internal server error",
            error: error.message || error
        });
    }
});


export const productGet = asyncHandler(async (req, res) => {
    const { id } = req.params

    const product = await Product.findById(id)
    if (!product) return res.status(404).json("Product not exist")

    res.status(200).json({
        message: 'Product found',
        data: product
    })

})
export const productDelete = asyncHandler(async (req, res) => {
    const { id } = req.params
    try {

        const product = await Product.findByIdAndDelete(id)
        if (!product) return res.status(404).json("Product not exist")
        res.status(200).json('Product Deleted Successfully');

    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        })
    }

})
export const productEdit = asyncHandler(async (req, res) => {
    const { id } = req.params
    const { name, description, price, image, category } = req.body
    try {
        const product = await Product.findByIdAndUpdate(id, {
            name, description, price, image, category
        })
        if (!product) return res.status(404).json("Product not exist")

        res.status(200).json('Product Updated Successfully');



    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        })
    }
})
export const productAll = asyncHandler(async (req, res) => {
    const { category } = req.query;

    let filter = {};
    if (category) {
        filter.category = category;
    }

    const product = await Product.find(filter);
    res.status(200).json({
        message: 'Products Found',
        data: product,
    });
});


export const productSearch = asyncHandler(async (req, res) => {
    const { query, category } = req.query;
  
    
    const filters = {};
  
    if (query) {
      filters.name = new RegExp(query, 'i');
    }
  
    
    if (category) {
      filters.category = category;
    }
  
    
    const products = await Product.find(filters);
  
    res.status(200).json({
      message: 'Products Found',
      data: products,
    });
  });
  