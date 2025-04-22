import 'dart:convert';

import 'package:restaurant_bloc_frontend/features/cart/domain/entities/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartLocalDataSource {
  final SharedPreferences prefs;
  final String key = 'cart_items';

  CartLocalDataSource(this.prefs);

  Future<void> saveCartItems(List<CartItem> items) async {
    final jsonList = items.map((item) => item.toJson()).toList();
    await prefs.setString(key, jsonEncode(jsonList));
  }

  List<CartItem> getCartItems() {
    final jsonString = prefs.getString(key);
    if (jsonString == null) return [];
    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => CartItem.fromJson(e)).toList();
  }

  Future<void> clearCart() async {
    await prefs.remove(key);
  }
}
