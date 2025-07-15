import 'package:e_commerce_app/screens/category/category_product/category_product_provider.dart';
import 'package:e_commerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProductScreen extends StatelessWidget {
  final String categoryName;
  const CategoryProductScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CategoryProductProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.blue,))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: provider.products.length,
              itemBuilder: (conetxt, index) {
                final product = provider.products[index];
                return ProductCard(product: product);
              },
            ),
    );
  }
}
