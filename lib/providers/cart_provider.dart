import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  static const String _storageKey = 'cart_items';

  List<CartItem> get items => [..._items];

  int get itemCount => _items.length;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  Future<void> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString(_storageKey);
    if (cartJson != null) {
      final List<dynamic> decodedData = json.decode(cartJson);
      _items = decodedData.map((item) => CartItem.fromMap(item)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(_items.map((item) => item.toMap()).toList());
    await prefs.setString(_storageKey, encodedData);
  }

  void addItem(CartItem item) {
    final existingItemIndex = _items.indexWhere((i) => i.id == item.id);
    if (existingItemIndex >= 0) {
      _items[existingItemIndex].quantity += 1;
    } else {
      _items.add(item);
    }
    notifyListeners();
    _saveItems();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
    _saveItems();
  }

  void updateQuantity(String id, int quantity) {
    if (quantity < 1) return;
    final itemIndex = _items.indexWhere((item) => item.id == id);
    if (itemIndex >= 0) {
      _items[itemIndex].quantity = quantity;
      notifyListeners();
      _saveItems();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
    _saveItems();
  }
}
