import express from 'express'

const router=express.Router();

router.post('/create-order',orderCreate)
router.post('/get-order',orderGet)
router.delete('/delete-order',orderDelete)
router.put('/edit-order',orderEdit)
router.get('/all-porder',orderAll)

