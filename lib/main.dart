import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/screens/carts.dart';
import 'package:shop_app/screens/orders.dart';
import 'package:shop_app/screens/product_details.dart';
import 'package:shop_app/screens/product_overview.dart';
import 'package:shop_app/screens/user_product_edit.dart';
import 'package:shop_app/screens/user_products.dart';
import './providers/products.dart';

import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Order()),
        ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrangeAccent,
            fontFamily: 'Lato'),
        home: ProductsOverview(),
        routes: {
          // '/': (ctx) => ProductsOverview(),
          ProductDetails.routeName: (ctx) => ProductDetails(),
          Carts.routeName: (ctx) => Carts(),
          Orders.routeName: (ctx) => Orders(),
          UserProducts.routeName: (ctx) => UserProducts(),
          UserProductEdit.routeName: (ctx) => UserProductEdit(),
        },
      ),
    );
  }
}
