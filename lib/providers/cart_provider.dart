import 'package:flutter/material.dart';
import 'package:timbu_v2/model/order.dart';
import 'package:timbu_v2/model/product.dart';

class CartProvider extends ChangeNotifier {
  // list of products in the cart
  List<Product> userCartItems = [];
  // List of quantities corresponding to each product
  List<int> quantities = [];
  // List of products in the wishlist
  List<Product> userWishlist = [];
  // order history list
  List<Order> orderHistory = [];

  // Get cart
  List<Product> getUserCartItems() {
    return userCartItems;
  }

  // Get quantities
  List<int> getQuantities() {
    return quantities;
  }

  // Add to cart
  void addToCart(Product product) {
    if (userCartItems.contains(product)) {
      int index = userCartItems.indexOf(product);
      quantities[index]++;
    } else {
      userCartItems.add(product);
      quantities.add(1);
    }
    notifyListeners();
  }

  // Remove from cart
  void removeFromCart(Product product) {
    if (userCartItems.contains(product)) {
      int index = userCartItems.indexOf(product);
      userCartItems.removeAt(index);
      quantities.removeAt(index);
      notifyListeners();
    }
  }

  // Clear cart
  void clearCart() {
    userCartItems.clear();
    quantities.clear();
    notifyListeners();
  }

  // Increment quantity
  void incrementQuantity(Product product) {
    if (userCartItems.contains(product)) {
      int index = userCartItems.indexOf(product);
      quantities[index]++;
      notifyListeners();
    }
  }

  // Decrement quantity
  void decrementQuantity(Product product) {
    if (userCartItems.contains(product)) {
      int index = userCartItems.indexOf(product);
      if (quantities[index] > 1) {
        quantities[index]--;
      } else {
        userCartItems.removeAt(index);
        quantities.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Get cart count
  int getCartCount() {
    int count = 0;
    for (int quantity in quantities) {
      count += quantity;
    }
    return count;
  }

  // Get total amount
  double get totalAmount {
    double total = 0.0;
    for (int i = 0; i < userCartItems.length; i++) {
      total += userCartItems[i].currentPrice! * quantities[i];
    }
    return total;
  }

  //! Wishlist methods
  List<Product> getUserWishlist() {
    return userWishlist;
  }

  void addToWishlist(Product product) {
    if (!userWishlist.contains(product)) {
      userWishlist.add(product);
      notifyListeners();
    }
  }

  void removeFromWishlist(Product product) {
    if (userWishlist.contains(product)) {
      userWishlist.remove(product);
      notifyListeners();
    }
  }

  bool isInWishlist(Product product) {
    return userWishlist.contains(product);
  }

  //! Order history methods
  List<Order> getOrderHistory() {
    return orderHistory;
  }

  void placeOrder() {
    if (userCartItems.isNotEmpty) {
      Order newOrder = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        products: List.from(userCartItems),
        quantities: List.from(quantities),
        totalAmount: totalAmount,
        date: DateTime.now(),
      );

      orderHistory.add(newOrder);
      clearCart();
      notifyListeners();
    }
  }
}
