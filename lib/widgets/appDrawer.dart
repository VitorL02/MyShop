import 'package:flutter/material.dart';
import '../routes/routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
          title: Text('Bem vindo Usúario!'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Loja'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.credit_card),
          title: Text('Pedidos'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
          },
        ),
      ],
    ));
  }
}
