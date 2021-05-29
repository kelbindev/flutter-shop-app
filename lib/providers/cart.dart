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

  double get totalAmount{
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.qty;
    });
    return total;
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

  void removeSingleItem(String productId){
    if (_items[productId]!.qty > 1){
 _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              qty: value.qty - 1,
              price: value.price));
    }
    else
    {
      _items.remove(productId);
    }

    notifyListeners();
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart(){
    _items = {};
    notifyListeners();
  }
}
