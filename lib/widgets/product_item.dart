import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_details.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // final double price;

  // ProductItem(this.id, this.title, this.imageUrl, this.price);

  @override
  Widget build(BuildContext context) {
    final _product = Provider.of<Product>(context, listen: false);
    final _cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        header: Text(_product.title),
        child: GestureDetector(
          child: Image.network(
            _product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetails.routeName,
              arguments: _product.id,
            );
          },
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (ctx, _product, _) => IconButton(
              onPressed: () {
                _product.toggleFavorite();
              },
              icon: Icon(_product.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_outline),
              color: Theme.of(context).accentColor,
            ),
          ),
          backgroundColor: Colors.black87,
          title: Text(
            '\$${_product.price.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              _cart.addItem(_product.id, _product.price, _product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Item added to cart',
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                     onPressed: () {
                       _cart.removeSingleItem(_product.id);
                     }),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
