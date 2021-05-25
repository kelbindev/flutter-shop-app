import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int qty;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.qty,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {

  };

  Map<String, CartItem> get getItems {
    return {..._items};
  }

  int get itemCount{
    return
    _items.isEmpty ? 
    0 : _items.length;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              qty: value.qty + 1,
              price: value.price));
    } else {
      _items.putIfAbsent(productId,
          () => CartItem(id: productId, title: title, qty: 1, price: price));
    }

    print(productId);

    notifyListeners();
  }
}
