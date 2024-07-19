import 'package:flutter/material.dart';
import 'package:timbu_v2/model/product.dart';

class CartProvider extends ChangeNotifier {
  // list of products in the cart
  List<Product> userCartItems = [];
  // List of quantities corresponding to each product
  List<int> quantities = [];
  // List of products in the wishlist
  List<Product> userWishlistItems = [];

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
      if (quantities[index] > 1) {
        quantities[index]--;
      } else {
        userCartItems.removeAt(index);
        quantities.removeAt(index);
      }
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
  List<Product> getUserWishlistItems() {
    return userWishlistItems;
  }

  void addToWishlist(Product product) {
    if (!userWishlistItems.contains(product)) {
      userWishlistItems.add(product);
      notifyListeners();
    }
  }

  void removeFromWishlist(Product product) {
    if (userWishlistItems.contains(product)) {
      userWishlistItems.remove(product);
      notifyListeners();
    }
  }

  bool isInWishlist(Product product) {
    return userWishlistItems.contains(product);
  }

  // // Add to cart
  // void addToCart(Product product) {
  //   userCartItems.add(product);
  //   notifyListeners();
  // }

  // // Remove from cart
  // void removeFromCart(Product product) {
  //   userCartItems.remove(product);
  //   notifyListeners();
  // }

  // // clear cart
  // void clearCart() {
  //   userCartItems.clear();
  //   notifyListeners();
  // }

  // int getCartCount() {
  //   return userCartItems.length;
  // }

  // double get totalAmount {
  //   double total = 0.0;
  //   for (var item in userCartItems) {
  //     total += item.currentPrice!;
  //   }
  //   return total;
  // }
}
