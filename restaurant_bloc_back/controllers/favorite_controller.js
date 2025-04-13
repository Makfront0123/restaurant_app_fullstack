import Favorite from '../models/favorite_model.js';

export const getFavorites = async (req, res) => {
  try {
    const favorites = await Favorite.findOne({ user: req.user.id }).populate('items');
    res.status(200).json(favorites || { items: [] });
  } catch (err) {
    res.status(500).json({ message: 'Error al obtener favoritos', error: err.message });
  }
};

export const addFavorite = async (req, res) => {
  const { itemId } = req.body;
  try {
    let fav = await Favorite.findOne({ user: req.user.id });
    if (!fav) {
      fav = new Favorite({ user: req.user.id, items: [itemId] });
    } else {
      if (!fav.items.includes(itemId)) fav.items.push(itemId);
    }
    await fav.save();
    res.status(200).json(fav);
  } catch (err) {
    res.status(500).json({ message: 'Error al agregar favorito', error: err.message });
  }
};

export const removeFavorite = async (req, res) => {
  const { itemId } = req.body;
  try {
    const fav = await Favorite.findOne({ user: req.user.id });
    if (fav) {
      fav.items = fav.items.filter(item => item.toString() !== itemId);
      await fav.save();
    }
    res.status(200).json(fav);
  } catch (err) {
    res.status(500).json({ message: 'Error al eliminar favorito', error: err.message });
  }
};
