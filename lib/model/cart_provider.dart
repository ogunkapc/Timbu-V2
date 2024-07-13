import 'package:flutter/material.dart';
import 'package:timbu_v2/model/product.dart';

class CartProvider extends ChangeNotifier {
  // list of products in the cart
  List<Product> userCartItems = [];
  // get cart
  List<Product> getUserCartItems() {
    return userCartItems;
  }

  // Add to cart
  void addToCart(Product product) {
    userCartItems.add(product);
    notifyListeners();
  }

  // Remove from cart
  void removeFromCart(Product product) {
    userCartItems.remove(product);
    notifyListeners();
  }

  // clear cart
  void clearCart() {
    userCartItems.clear();
    notifyListeners();
  }

  int getCartCount() {
    return userCartItems.length;
  }

  double get totalAmount {
    double total = 0.0;
    for (var item in userCartItems) {
      total += item.currentPrice!;
    }
    return total;
  }
}
