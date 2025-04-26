import express from 'express'
import {productCreate,productGet,productAll,productDelete,productEdit,productSearch} from '../controllers/product_controller.js'
const router=express.Router();

router.post('/create-product',productCreate)
router.get('/get-product/:id',productGet)
router.get('/all-products',productAll)
router.delete('/delete-product/:id',productDelete)
router.put('/edit-product/:id',productEdit)
router.get('/search-products',productSearch)

export default router;