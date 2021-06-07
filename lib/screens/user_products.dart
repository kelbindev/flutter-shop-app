import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/user_product_edit.dart';
import 'package:shop_app/widgets/main_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProducts extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProduct();
  }

  @override
  Widget build(BuildContext context) {
    final _product = Provider.of<Products>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [IconButton(onPressed: () {
          Navigator.of(context).pushNamed(UserProductEdit.routeName,
                arguments: '');
        }, icon: Icon(Icons.add))],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: _product.items.length,
            itemBuilder: (ctx, i) => Column(
              children: [
                Divider(),
                UserProductItem(_product.items[i]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
