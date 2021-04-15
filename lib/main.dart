import 'package:flutter/material.dart';
import 'package:shop/views/productDetailScreen.dart';
import 'package:provider/provider.dart';

import './views/productsOverViewScreen.dart';
import './routes/routes.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Products(),
      child: MaterialApp(
        title: 'Minha Loja / compras',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverViewScreen(),
        routes: {
          AppRoutes.PRODUCTDETAIL: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
