import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/order.dart';

class OrderItemW extends StatelessWidget {
  final OrderItem orderItem;

  OrderItemW(this.orderItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${orderItem.amount}'),
            subtitle: Text(DateFormat('dd MM yyyy').format(orderItem.datetime)),
            trailing: IconButton(
              onPressed: () {}, 
              icon: Icon(Icons.expand_more)),
          )
        ],
      ),
    );
  }
}