import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime datetime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.datetime});
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get getOrders {
    return [..._orders];
  }

  int get getOrdersCount {
    return _orders.length;
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    String newid = (_orders.length + 1).toString();

    _orders.add(OrderItem(
        id: newid,
        amount: total,
        products: cartProducts,
        datetime: DateTime.now()));

    print(_orders.where((e) => e.id == newid).first.id.toString());

    notifyListeners();
  }
}
