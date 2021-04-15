import 'package:flutter/material.dart';

import '../data/DUMMY_DATA.dart';
import 'product.dart';

//Nessa classe vai acontecer o encapsulamento dos produtos e por ela ser usada na aplicação
//ChangeNotifier notifica quando uma mudança ocorre em um produto,se ele e deletado,modificado ou adicionado

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];
  //Metodo Direto pra entregar os itens favoritos
  List<Product> get favoriteItems {
    return items.where((prod) => prod.isFavorite).toList();
  }

// List<Product> get items => _items; = Referenciar a lista dessa maneira faz com que permita ter acesso direto a ela
// Referenciar [..._items] = cria uma copia de todos os items e fornece a aplicação

  void addProduct(Product product) {
    //Adicionar um item a lista e um evento ,o notify notifica pra  qualquer interessado
    _items.add(product);
    notifyListeners();
  }
}

//Metodo de Controle na aplicação globalmente
// bool _showFavoriteOnly = false;
// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();
// }

// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }
