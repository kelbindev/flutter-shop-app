import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/badge.dart';

import 'package:shop_app/widgets/products_grid.dart';

enum filterOptions { Favorite, All }

bool _showFavorites = false;

class ProductsOverview extends StatefulWidget {
  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
              onSelected: (filterOptions val) {
                setState(() {
                  if (val == filterOptions.Favorite) {
                    _showFavorites = true;
                  } else {
                    _showFavorites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: const Text('Only Favorites'),
                      value: filterOptions.Favorite,
                    ),
                    PopupMenuItem(
                      child: const Text('Show All'),
                      value: filterOptions.All,
                    ),
                  ]),
          Consumer<Cart>(
            builder: (_, _cart, ch) => Badge(
              key: UniqueKey(),
              child: ch == null ? Container() : ch,
              value: _cart.itemCount.toString(),
            ),
            child:
                IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
          ),
        ],
      ),
      body: ProductGrid(_showFavorites),
    );
  }
}
