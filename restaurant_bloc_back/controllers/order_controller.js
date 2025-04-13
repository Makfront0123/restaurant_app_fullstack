import Order from '../models/order_model.js';
import User from '../models/user_model.js';

export const createOrder = async (req, res) => {
  const { deliveryAddress, paymentMethod } = req.body;
  try {
    const user = await User.findById(req.user.id).populate('cart.item');
    const orderItems = user.cart.map(c => ({
      item: c.item._id,
      quantity: c.quantity,
      price: c.item.price
    }));
    const totalAmount = orderItems.reduce((sum, item) => sum + item.price * item.quantity, 0);

    const newOrder = new Order({
      user: req.user.id,
      items: orderItems,
      totalAmount,
      deliveryAddress,
      paymentMethod
    });

    await newOrder.save();
    user.cart = [];
    await user.save();

    res.status(201).json(newOrder);
  } catch (err) {
    res.status(500).json({ message: 'Error al crear la orden', error: err.message });
  }
};

export const getUserOrders = async (req, res) => {
  try {
    const orders = await Order.find({ user: req.user.id }).sort({ createdAt: -1 });
    res.status(200).json(orders);
  } catch (err) {
    res.status(500).json({ message: 'Error al obtener órdenes', error: err.message });
  }
};
