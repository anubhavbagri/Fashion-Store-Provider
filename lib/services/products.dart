import 'dart:convert';

import 'package:fashion_store/model/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSaveProducts() async {
    final url = Uri.parse(
        "https://fakestoreapi.com/products/category/women's%20clothing");

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        print('Error Loading data!');
      }

      final List<Product> updatedList = [];
      final jsonString = response.body;

      updatedList.addAll(productFromJson(jsonString));
      _items = updatedList;
      notifyListeners();
    } catch (error) {
      print(error.toString());
    } finally {}
  }
}
