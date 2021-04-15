import 'package:flutter/material.dart';
import '../providers/product.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //quando navegar ,agora ele passa o argumento e não o componente em si
    final Product product =
        ModalRoute.of(context).settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: Colors.purpleAccent[700].withOpacity(0.87),
      ),
      body: Center(
        child: Text('item'),
      ),
    );
  }
}
