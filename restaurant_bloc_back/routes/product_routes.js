import express from 'express'
import {productCreate,productGet,productAll,productDelete,productEdit} from '../controllers/product_controller.js'
const router=express.Router();

router.post('/create-product',productCreate)
router.get('/get-product/:id',productGet)
router.get('/all-products',productAll)
router.delete('/delete-product/:id',productDelete)
router.put('/edit-product/:id',productEdit)

export default router;