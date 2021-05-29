import 'package:flutter/material.dart';
import 'package:shop_app/screens/carts.dart';
import 'package:shop_app/screens/orders.dart';
import 'package:shop_app/screens/user_products.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget buildListTile(IconData icon, String label, Function onTapHandler){
      return ListTile(
        leading: Icon(icon),
        title: Text(label),
        onTap: () => onTapHandler(),
      );
    }

    return Drawer(
        child: Column(
          children: [
            AppBar(
              title: Text('Menu'),
              automaticallyImplyLeading: false,
            ),
            // Container(
            //   alignment: Alignment.centerLeft,
            //   padding: EdgeInsets.all(15),
            //   width: double.infinity,
            //   height: 80,
            //   color: Theme.of(context).primaryColor,
            //   child: const Text('Menu',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 28,
            //     fontWeight: FontWeight.bold
            //   ),),
            // ),
            Expanded(
              child: ListView(
                children: [
                  buildListTile(
                  Icons.home,
                  'Home',
                  () {
                    Navigator.of(context).pushNamed('/');
                  }
                ),
                Divider(),
                  buildListTile(
                  Icons.shopping_cart,
                  'Cart',
                  () {
                    Navigator.of(context).pushNamed(Carts.routeName);
                  }
                ),
                Divider(),
                buildListTile(
                  Icons.shopping_bag,
                  'Orders',
                  () {
                    Navigator.of(context).pushNamed(Orders.routeName);
                  }
                ),
                Divider(),
                buildListTile(
                  Icons.edit,
                  'Products',
                  () {
                    Navigator.of(context).pushReplacementNamed(UserProducts.routeName);
                  }
                ),
              ],),
            ),
          ],
        ),
      );
  }
}