import 'dart:async';

import 'package:e_commerce_app/screens/products/product_provider.dart';
import 'package:e_commerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  if (productProvider.timer?.isActive ?? false) {
                    productProvider.timer?.cancel();
                  }
                  productProvider.timer = Timer(
                    Duration(milliseconds: 700),
                    () {
                      productProvider.searchProduct(value);
                    },
                  );
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    size: 32,
                    color: Colors.grey,
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              productProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: productProvider.isSearching
                            ? productProvider.filteredList.length
                            : productProvider.products.length,
                        itemBuilder: (conetxt, index) {
                          final product = productProvider.isSearching
                              ? productProvider.filteredList[index]
                              : productProvider.products[index];
                          return ProductCard(product: product);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
