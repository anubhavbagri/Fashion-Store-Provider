import 'package:fashion_store/model/product.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  // counter for cart items
  int _counter = 0;
  int get counter => _counter;

  // grand total price of the cart items
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  List<Product> list = <Product>[];

  addProduct(int id, int quantity, String title, double price,
      String description, String image) {
    list.add(
      Product(
        id: id,
        quantity: quantity,
        title: title,
        price: price,
        description: description,
        image: image,
      ),
    );
    addCounter();
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

  void addQuantity(int index) {
    list[index].quantity++;
    notifyListeners();
  }

  void subtractQuantity(int index) {
    list[index].quantity--;
    notifyListeners();
  }

  int getCounter() {
    return _counter;
  }

  void addCounter() {
    _counter++;
    notifyListeners();
  }

  void subtractCounter() {
    _counter--;
    notifyListeners();
  }
}
