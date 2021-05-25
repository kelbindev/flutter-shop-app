import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_details.dart';
import 'package:shop_app/screens/product_overview.dart';
import './providers/products.dart';

import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      // value: Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrangeAccent,
          fontFamily: 'Lato'
        ),
        home: ProductsOverview(),
        routes: {
          // '/': (ctx) => ProductsOverview(),
          ProductDetails.routeName: (ctx) => ProductDetails()
        },
      ),
    );
  }
}

