import 'package:flutter/material.dart';

import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {})
          ],
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
    );
  }
}