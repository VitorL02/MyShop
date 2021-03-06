import 'dart:math';

import 'package:flutter/foundation.dart';
import './product.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price,
      @required this.productId});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get item {
    return {..._items};
  }

//Getter pra receber a quantidade de itens sem ter que clonar toda vez  os itens com o {..._items}
  int get itemCount {
    return _items.length;
  }

  double get totalAmout {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
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
            productId: product.id,
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
          productId: product.id,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeUniqueItem(productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existingItem) {
          // função que caso o item ja exista no carrinho de comprar,adiciona mais um pra o mesmo
          return CartItem(
            id: existingItem.id,
            title: existingItem.title,
            productId: existingItem.productId,
            quantity: existingItem.quantity - 1,
            price: existingItem.price,
          );
        },
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
