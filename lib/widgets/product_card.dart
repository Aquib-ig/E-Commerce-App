import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/cart/cart_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: Colors.grey[200],
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 160,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: product.thumbnail ?? "",
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(color: Colors.blue),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Text(
              product.title ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text("\$${product.price.toString()}"),
                const Spacer(),
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text("${product.rating}"),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[100],
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  context.read<CartProvider>().addCartItem(product);
                },
                child: const Text("Add to cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
