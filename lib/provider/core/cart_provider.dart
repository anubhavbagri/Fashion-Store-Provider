import 'package:fashion_store/model/product.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  List<Product> list = <Product>[];

  addProduct(int id, String title, double price, String description,
      String category, String image) {
    list.add(
      Product(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image,
      ),
    );
    notifyListeners();
  }

  delete(int index) {
    list.removeAt(index);
    notifyListeners();
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    notifyListeners();
  }

  void subtractTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    notifyListeners();
  }

  double getTotalPrice() {
    return _totalPrice;
  }

  void addCounter() {
    _counter++;
    notifyListeners();
  }

  void subtractCounter() {
    _counter--;
    notifyListeners();
  }

  int getCounter() {
    return _counter;
  }
}
