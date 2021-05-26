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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Preço",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Lato",
                    fontSize: 22,
                  )),
              SizedBox(height: 10),
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepPurple[400],
                  boxShadow: [
                    BoxShadow(offset: Offset(1, 5), color: Colors.black)
                  ],
                ),
                child: Center(
                  child: Text(
                    'R\$ ${product.price}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
