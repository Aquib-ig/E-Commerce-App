import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  final String baseUrl = "https://dummyjson.com/products?limit=0";
  List<Product> products = [];
  List<Product> filteredList = [];
  bool isSearching = false;
  bool isLoading = false;
  Timer? timer;

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonString = jsonDecode(response.body);
        List<dynamic> data = jsonString["products"];
        products = data.map((e) => Product.fromJson(e)).toList();
        print(products);
      } else {
        log("failed to load products");
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchProduct(String query) async {
    print(query);
    isSearching = true;
    notifyListeners();

    final result = products
        .where(
          (item) =>
              item.title!.toLowerCase().contains(query.toLowerCase()) ||
              item.description!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    filteredList = result;
    notifyListeners();
  }
}
