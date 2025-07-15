import 'package:e_commerce_app/models/product_model.dart';

class Cart {
  final Product product;
  int quantity;

  Cart({required this.product, this.quantity = 1});

  factory Cart.fromjson(Map<String, dynamic> json) {
    return Cart(
      product: Product.fromJson(json["product"]),
      quantity: json["quantity"] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {"product": product.toJson(), "quantity": quantity};
  }
}
