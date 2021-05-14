import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/appDrawer.dart';

import '../providers/orders.dart';
import '../widgets/orderWidget.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Orders orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      body: ListView.builder(
          itemCount: orders.itemsCount,
          itemBuilder: (ctx, i) => OrderWidget(orders.items[i])),
      drawer: AppDrawer(),
    );
  }
}
