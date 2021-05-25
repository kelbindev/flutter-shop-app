import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            leading: 
            Consumer<Product>(
      builder: (ctx, _product, _) => IconButton(
              onPressed: () {
                _product.toggleFavorite();
              },
              icon: Icon(
                _product.isFavorite ? 
                Icons.favorite : Icons.favorite_outline
                ),
              color: Theme.of(context).accentColor,
            ),),
            backgroundColor: Colors.black87,
            title: Text(
              '\$${_product.price.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      );
  }
}
