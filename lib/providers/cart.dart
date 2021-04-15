import 'dart:math';

import 'package:flutter/foundation.dart';
import './product.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> get item {
    return {..._items};
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) {
          // função que caso o item ja exista no carrinho de comprar,adiciona mais um pra o mesmo
          return CartItem(
            id: existingItem.id,
            title: existingItem.title,
            quantity: existingItem.quantity + 1,
            price: existingItem.price,
          );
        },
      );
    }
    //Adiciona o produto no carrinho
    else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          title: product.title,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }
}
