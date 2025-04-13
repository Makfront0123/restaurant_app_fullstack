import express from 'express';

const router= express.Router();

router.post('/add-cart',orderCreate)
router.post('/removeProduct-cart',orderDeleteProduct)
router.delete('/clear-cart',orderDeleteAll)
router.put('/edit-cart',orderEdit)



export default router;