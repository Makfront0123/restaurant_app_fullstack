import Category from "../models/category_model.js";
import asyncHandler from "express-async-handler"

export const createCategory = asyncHandler(async (req, res) => {
    const { name, description, image } = req.body
    try {
        if (!name) return res.status(404).json('Name is required')
        if (!description) return res.status(404).json('Description is required')
        if (!image) return res.status(404).json('Image is required')

        const newCat = new Category({
            name,
            description,
            image
        })

        await newCat.save()
        return res.status(201).json(
            {
                message: "Category created successfully",
                data: newCat
            }
        );

    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        })
    }
})
export const editCategory = asyncHandler(async (req, res) => {
    const { id } = req.params;
    const { name, description, image } = req.body;

    try {
        const category = await Category.findById(id);
        if (!category) return res.status(404).json('Category not found');

        if (name) category.name = name;
        if (description) category.description = description;
        if (image) category.image = image;

        await category.save();

        res.status(200).json('Category Updated Successfully');
    } catch (error) {
        console.error("Edit Category Error:", error);
        res.status(500).json({
            message: "Internal server error",
            error: error.message || error
        });
    }
});

export const deleteCategory = asyncHandler(async (req, res) => {
    const { id } = req.params;
    try {
        if (!id) return res.status(404).json('Id is required');
        const category = await Category.findByIdAndDelete(id);
        if (!category) return res.status(404).json('Category not found');
        res.status(200).json('Category Deleted Successfully');
    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        });
    }
});
export const getAllCategory = asyncHandler(async (req, res) => {
    try {
        const categories = await Category.find();
        res.status(200).json(
            {
                message: "Categories found",
                data: categories
            }
        );
    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        });
    }
})

export const getCategory = asyncHandler(async (req, res) => {
    const { id } = req.params;
    try {
        const category = await Category.findById(id);
        if (!category) return res.status(404).json('Category not found');
        res.status(200).json(category);
    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        });
    }
})

export const searchCategory = asyncHandler(async (req, res) => {
    const { query } = req.query;
    try {
        const category = await Category.find({ name: new RegExp(query, 'i') });
        res.status(200).json({
            message: "Categories found",
            data: category
        });
    } catch (error) {
        res.status(500).json({
            message: "Internal server error",
            error
        });
    }
})