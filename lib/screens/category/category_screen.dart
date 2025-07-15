import 'package:e_commerce_app/screens/category/category_product/category_product_provider.dart';
import 'package:e_commerce_app/screens/category/category_product/category_products.dart';
import 'package:e_commerce_app/screens/category/category_provider.dart';
import 'package:e_commerce_app/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      body: categoryProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: categoryProvider.categories.length,
              itemBuilder: (context, index) {
                final category = categoryProvider.categories[index];
                return CategoryTile(
                  name: category.name,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) =>
                              CategoryProductProvider(category.url),
                          child: CategoryProductScreen(
                            categoryName: category.name,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
