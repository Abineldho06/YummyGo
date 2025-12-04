import 'package:flutter/material.dart';
import 'package:yummygo/models/dish_model.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, DishModel> _cartItems = {};

  Map<int, DishModel> get cartItems => _cartItems;

  void addToCart(DishModel dish) {
    if (_cartItems.containsKey(dish.id)) {
      _cartItems[dish.id]!.quantity++;
    } else {
      dish.quantity = 1;
      _cartItems[dish.id] = dish;
    }

    notifyListeners();
  }

  void removeFromCart(DishModel dish) {
    if (_cartItems.containsKey(dish.id)) {
      if (_cartItems[dish.id]!.quantity > 1) {
        _cartItems[dish.id]!.quantity--;
      } else {
        _cartItems.remove(dish.id);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int get totalItems {
    int total = 0;

    _cartItems.forEach((key, dish) {
      total += dish.quantity;
    });

    return total;
  }

  double get totalPrice {
    double sum = 0;

    _cartItems.forEach((key, dish) {
      sum += dish.quantity * dish.price;
    });

    return sum;
  }
}
