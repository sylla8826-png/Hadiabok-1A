import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

class CartService extends ChangeNotifier {
  CartService._private();
  static final CartService instance = CartService._private();

  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);

  void add(Product p) {
    _items.add(p);
    notifyListeners();
  }

  void remove(Product p) {
    _items.removeWhere((e) => e.id == p.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}