import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier {
  final String baseUrl = "https://dummyjson.com/products/categories";
  List<Category> categories = [];
  bool isLoading = false;

  CategoryProvider() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        categories = data.map((e) => Category.fromJson(e)).toList();
      } else {
        log("Failed to load categories");
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
