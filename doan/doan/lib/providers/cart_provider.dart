import 'package:flutter/material.dart';
import 'package:doan/model/item.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  Map<int, List<CartItem>> _tableItems = {};

  List<CartItem> get items => _items;
  Map<int, List<CartItem>> get tableItems => _tableItems;

  void addToCart(Item item, double icePercentage, double sugarPercentage, {int? tableNumber}) {
    DateTime now = DateTime.now();
    if (tableNumber != null) {
      if (_tableItems.containsKey(tableNumber)) {
        final index = _tableItems[tableNumber]!.indexWhere((cartItem) => cartItem.item.id == item.id);
        if (index >= 0) {
          _tableItems[tableNumber]![index].quantity += 1;
        } else {
          _tableItems[tableNumber]!.add(CartItem(item: item, quantity: 1, icePercentage: icePercentage, sugarPercentage: sugarPercentage, tableNumber: tableNumber, addedTime: now));
        }
      } else {
        _tableItems[tableNumber] = [CartItem(item: item, quantity: 1, icePercentage: icePercentage, sugarPercentage: sugarPercentage, tableNumber: tableNumber, addedTime: now)];
      }
    } else {
      final index = _items.indexWhere((cartItem) => cartItem.item.id == item.id);
      if (index >= 0) {
        _items[index].quantity += 1;
      } else {
        _items.add(CartItem(item: item, quantity: 1, icePercentage: icePercentage, sugarPercentage: sugarPercentage, addedTime: now));
      }
    }
    notifyListeners();
  }

  void updateCartItemQuantity(Item item, int quantity, {int? tableNumber}) {
    if (tableNumber != null) {
      if (_tableItems.containsKey(tableNumber)) {
        final index = _tableItems[tableNumber]!.indexWhere((cartItem) => cartItem.item.id == item.id);
        if (index >= 0) {
          _tableItems[tableNumber]![index].quantity = quantity;
        }
      }
    } else {
      final index = _items.indexWhere((cartItem) => cartItem.item.id == item.id);
      if (index >= 0) {
        _items[index].quantity = quantity;
      }
    }
    notifyListeners();
  }

  void removeFromCart(Item item, {int? tableNumber}) {
    if (tableNumber != null) {
      if (_tableItems.containsKey(tableNumber)) {
        final index = _tableItems[tableNumber]!.indexWhere((cartItem) => cartItem.item.id == item.id);
        if (index >= 0) {
          _tableItems[tableNumber]!.removeAt(index);
        }
      }
    } else {
      final index = _items.indexWhere((cartItem) => cartItem.item.id == item.id);
      if (index >= 0) {
        _items.removeAt(index);
      }
    }
    notifyListeners();
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((cartItem) {
      total += cartItem.item.price * cartItem.quantity;
    });
    _tableItems.forEach((tableNumber, cartItems) {
      cartItems.forEach((cartItem) {
        total += cartItem.item.price * cartItem.quantity;
      });
    });
    return total;
  }

  double getTableTotalAmount(int tableNumber) {
    if (_tableItems.containsKey(tableNumber)) {
      return _tableItems[tableNumber]!
          .fold(0, (sum, cartItem) => sum + (cartItem.item.price * cartItem.quantity));
    }
    return 0;
  }

  void clearCart() {
    _items = [];
    notifyListeners();
  }

  void clearTableCart(int tableNumber) {
    _tableItems.remove(tableNumber);
    notifyListeners();
  }
   void updateItemQuantity(Item item, int quantity) {
    // Implement the logic to update the item quantity in the cart
    // For example:
    final cartItem = _items.firstWhere((cartItem) => cartItem.item == item);
    cartItem.quantity = quantity;
    notifyListeners();
  }
}