import express from 'express'

const router=express.Router();

router.post('/create-product',productCreate)
router.post('/get-product',productGet)
router.delete('/delete-product',productDelete)
router.put('/edit-product',productEdit)
router.get('/all-products',productAll)

