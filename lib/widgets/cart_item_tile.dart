import 'package:e_commerce_app/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartItemTile extends StatelessWidget {
  final Cart cartItem;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.cartItem,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            cartItem.product.thumbnail ?? "",
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          cartItem.product.title ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          "Qty: ${cartItem.quantity} x \$${cartItem.product.price}",
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
          onPressed: onRemove,
          icon: const Icon(Icons.delete, color: Colors.red),
        ),
      ),
    );
  }
}
