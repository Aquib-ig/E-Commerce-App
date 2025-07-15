import 'dart:convert';

import 'package:e_commerce_app/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  Future<void> saveCartItems(List<Cart> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = cartItems
        .map((item) => jsonEncode(item.toJson()))
        .toList();
    await prefs.setStringList("cartItem", data);
  }

  Future<List<Cart>> loadCartItem() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList("cartItem") ?? [];
    return data.map((item) => Cart.fromjson(jsonDecode(item))).toList();
  }
}
