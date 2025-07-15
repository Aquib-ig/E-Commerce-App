import 'dart:convert';

import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryProductProvider extends ChangeNotifier {
  List<Product> products = [];
  bool isLoading = false;

  CategoryProductProvider( String url) {
    fetchProductFromCategory(url);
  }

  Future<void> fetchProductFromCategory(String url) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonString = jsonDecode(response.body);
        List<dynamic> data = jsonString["products"];
        products = data.map((e) => Product.fromJson(e)).toList();
      } else {
        print("Failed to load products");
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
