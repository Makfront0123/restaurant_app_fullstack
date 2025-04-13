import express from "express"
import { createCategory, deleteCategory, editCategory, getAllCategory, getCategory } from "../controllers/category_controller.js";
const router = express.Router();

router.post("/create-category", createCategory)
router.delete("/delete-category/:id", deleteCategory)
router.put("/edit-category/:id", editCategory)
router.get("/all-category", getAllCategory)
router.get("/get-category/:id", getCategory)

export default router;