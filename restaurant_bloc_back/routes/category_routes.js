import express from "express"
import { createCategory, deleteCategory, editCategory,searchCategory,getAllCategory, getCategory,   } from "../controllers/category_controller.js";
const router = express.Router();

router.post("/create-category", createCategory)
router.delete("/delete-category/:id", deleteCategory)
router.put("/edit-category/:id", editCategory)
router.get("/all-category", getAllCategory)
router.get("/get-category/:id", getCategory)
router.get("/search-category", searchCategory)

export default router;