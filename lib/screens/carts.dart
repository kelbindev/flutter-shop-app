import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/cart_item.dart';
import 'package:shop_app/widgets/main_drawer.dart';

class Carts extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(context);
    final _order = Provider.of<Order>(context,listen: false);

    void orderNow(List<CartItem> _cartItems, double total){
      _order.addOrder(_cartItems, total);
      _cart.clearCart();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${_cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6!
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {
                        orderNow(_cart.getItems.values.toList(), _cart.totalAmount);
                    },
                     child: const Text('ORDER NOW', style: TextStyle(fontWeight: FontWeight.bold),),
                     ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              itemCount: _cart.itemCount,
              itemBuilder: (ctx,i) =>
              CartItemW(_cart.getItems.values.toList()[i].id,
              _cart.getItems.keys.toList()[i],
              _cart.getItems.values.toList()[i].title,
              _cart.getItems.values.toList()[i].price,
              _cart.getItems.values.toList()[i].qty)
              )
            ),
        ],
      ),
    );
  }
}
