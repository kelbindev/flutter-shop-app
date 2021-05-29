import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetails extends StatelessWidget {
  // final String _title;

  // ProductDetails(this._title);

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;

    final _product =
        Provider.of<Products>(context, listen: false).getProductById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(_product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(_product.imageUrl, fit: BoxFit.cover),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$${_product.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                '${_product.description}',
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
