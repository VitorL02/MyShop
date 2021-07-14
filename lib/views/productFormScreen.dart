import 'package:flutter/material.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({Key key}) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario do Produto'),
      ),
    );
  }
}
