import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/routes/routes.dart';

import '../widgets/cartItemWidget.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final cartItems = cart.item.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Column(children: <Widget>[
        Card(
          margin: EdgeInsets.all(25),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                Chip(
                  label: Text(
                    'R\$ ${cart.totalAmout}',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    //Recebe a "ordem de compra"
                    Provider.of<Orders>(context, listen: false).addOrder(cart);
                    //Limpa o carrinho quando o pedido e feito
                    cart.clear();
                  },
                  child: Text('COMPRAR'),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: (ctx, i) => CartItemWidget(cartItems[i]),
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
          },
          child: Icon(Icons.credit_card)),
    );
  }
}
