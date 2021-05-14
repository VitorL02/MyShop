import 'package:flutter/material.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/views/ordersScreen.dart';
import 'package:shop/views/productDetailScreen.dart';
import 'package:provider/provider.dart';

import './views/cartScreen.dart';
import './views/productsOverViewScreen.dart';
import './routes/routes.dart';
import './providers/products.dart';
import './providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Criação de um multiProvider a aplicação precisa gerenciar os estados do carrinho e dos produtos quando modificados com um favorito
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Minha Loja / compras',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.black54,
          fontFamily: 'Lato',
        ),
        home: ProductsOverViewScreen(),
        routes: {
          AppRoutes.PRODUCTDETAIL: (ctx) => ProductDetailScreen(),
          AppRoutes.CART: (ctx) => CartScreen(),
          AppRoutes.ORDERS: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
