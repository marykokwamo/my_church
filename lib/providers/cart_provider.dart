import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/cart_item.dart';
import 'base_provider.dart';

class CartProvider extends BaseProvider {
  Map<String, CartItem> _items = {};
  static const String _storageKey = 'cart_items';

  Map<String, CartItem> get items => {..._items};
  int get itemCount => _items.length;

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  Future<void> loadItems() async {
    await wrapError(() async {
      final prefs = await SharedPreferences.getInstance();
      final String? cartJson = prefs.getString(_storageKey);
      if (cartJson != null) {
        final List<dynamic> decodedData = json.decode(cartJson);
        _items = decodedData.map((item) => CartItem.fromMap(item)).fold({}, (map, item) => map..[item.id] = item);
        notifyListeners();
      }
    });
  }

  Future<void> _saveItems() async {
    await wrapError(() async {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = json.encode(_items.values.map((item) => item.toMap()).toList());
      await prefs.setString(_storageKey, encodedData);
    });
  }

  Future<void> addItem(String productId, double price, String title, String image, {String author = ''}) async {
    await wrapError(() async {
      if (_items.containsKey(productId)) {
        _items.update(
          productId,
          (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity + 1,
            image: existingCartItem.image,
            author: existingCartItem.author,
          ),
        );
      } else {
        _items.putIfAbsent(
          productId,
          () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1,
            image: image,
            author: author,
          ),
        );
      }
      notifyListeners();
      await _saveItems();
    });
  }

  Future<void> removeItem(String productId) async {
    await wrapError(() async {
      _items.remove(productId);
      notifyListeners();
      await _saveItems();
    });
  }

  Future<void> removeSingleItem(String productId) async {
    await wrapError(() async {
      if (!_items.containsKey(productId)) {
        return;
      }
      if (_items[productId]!.quantity > 1) {
        _items.update(
          productId,
          (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity - 1,
            image: existingCartItem.image,
            author: existingCartItem.author,
          ),
        );
      } else {
        _items.remove(productId);
      }
      notifyListeners();
      await _saveItems();
    });
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    await wrapError(() async {
      if (!_items.containsKey(productId)) {
        return;
      }
      if (newQuantity <= 0) {
        await removeItem(productId);
      } else {
        _items.update(
          productId,
          (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: newQuantity,
            image: existingCartItem.image,
            author: existingCartItem.author,
          ),
        );
        notifyListeners();
        await _saveItems();
      }
    });
  }

  Future<void> clear() async {
    await wrapError(() async {
      _items = {};
      notifyListeners();
      await _saveItems();
    });
  }
}
