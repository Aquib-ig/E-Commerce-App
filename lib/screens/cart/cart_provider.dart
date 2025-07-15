import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/cart_service.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final cartService = CartService();
  final List<Cart> _cartItems = [];
  List<Cart> get cartItems => _cartItems;

  double get totalPrice {
    return _cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price ?? 0) * item.quantity,
    );
  }

  CartProvider() {
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    final items = await cartService.loadCartItem();
    _cartItems.addAll(items);
    notifyListeners();
  }

  void addCartItem(Product product) {
  final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
  );

  if (index != -1) {
    _cartItems[index].quantity += 1;
  } else {
    _cartItems.add(Cart(product: product, quantity: 1));
  }

  cartService.saveCartItems(_cartItems);
  notifyListeners();
}

  void deleteCartItem(Product product) {
  _cartItems.removeWhere((item) => item.product.id == product.id);
  cartService.saveCartItems(_cartItems);
  notifyListeners();
}
void increaseItem(Product product) {
  final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
  );

  if (index != -1) {
    _cartItems[index].quantity += 1;
    cartService.saveCartItems(_cartItems);
    notifyListeners();
  }
}
void decreaseItem(Product product) {
  final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
  );

  if (index != -1) {
    if (_cartItems[index].quantity > 1) {
      _cartItems[index].quantity -= 1;
    } else {
      _cartItems.removeAt(index);
    }
    cartService.saveCartItems(_cartItems);
    notifyListeners();
  }
}
}