import User from '../models/user_model.js';

export const getCart = async (req, res) => {
  try {
    const user = await User.findById(req.user.id).populate('cart.item');
    res.status(200).json(user.cart || []);
  } catch (err) {
    res.status(500).json({ message: 'Error al obtener el carrito', error: err.message });
  }
};

export const addToCart = async (req, res) => {
  const { itemId, quantity } = req.body;
  try {
    const user = await User.findById(req.user.id);
    const existing = user.cart.find(c => c.item.toString() === itemId);
    if (existing) {
      existing.quantity += quantity;
    } else {
      user.cart.push({ item: itemId, quantity });
    }
    await user.save();
    res.status(200).json(user.cart);
  } catch (err) {
    res.status(500).json({ message: 'Error al agregar al carrito', error: err.message });
  }
};

export const removeFromCart = async (req, res) => {
  const { itemId } = req.body;
  try {
    const user = await User.findById(req.user.id);
    user.cart = user.cart.filter(c => c.item.toString() !== itemId);
    await user.save();
    res.status(200).json(user.cart);
  } catch (err) {
    res.status(500).json({ message: 'Error al quitar del carrito', error: err.message });
  }
};
