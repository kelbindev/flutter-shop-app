import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:http/http.dart' as http;

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

  Future<void> fetchAndSetOrder() async {
    final url = Uri.parse(
        'https://shop-app-f45aa-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json');
    try {
      final response = await http.get(url);
      if (response.body.toString() == "null"){
        return;
      }
      
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<OrderItem> _loadedData = [];
      print(extractedData);

      extractedData.forEach((orderId, orderData) {
        _loadedData.add(OrderItem(
            id: orderId,
            amount: orderData['amount'],
            datetime: DateTime.parse(orderData['datetime']),
            products: (orderData['products'] as List<dynamic>)
                .map((e) => CartItem(
                    id: e['id'],
                    title: e['title'],
                    qty: e['qty'],
                    price: e['price']))
                .toList()));
      });

      _orders = _loadedData.reversed.toList();

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    String newid = "ci" + (_orders.length + 1).toString();
    final timeStamp = DateTime.now();

    final url = Uri.parse(
        'https://shop-app-f45aa-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json');

    final response = await http.post(url,
        body: json.encode({
          'id': newid,
          'amount': total,
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'price': e.price,
                    'qty': e.qty,
                    'title': e.title
                  })
              .toList(),
          'datetime': timeStamp.toIso8601String(),
        }));

    if (response.statusCode >= 400) {
      notifyListeners();
      throw HttpException('could not submit order.');
    }

    _orders.add(OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        datetime: timeStamp));

    notifyListeners();
  }
}
