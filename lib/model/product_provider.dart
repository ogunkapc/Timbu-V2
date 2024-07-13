import 'package:flutter/material.dart';
import 'package:timbu_v2/model/product.dart';
import 'package:timbu_v2/service/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final TimbuApi api;
  bool isLoading = false;
  String _errorMessage = '';

  ProductProvider({required this.api});

  List<Product> productsList = [];
  // list of products in the cart
  List<Product> userCartItems = [];

  // get list of products
  List<Product> getProductsList() {
    return productsList;
  }

  // get cart
  List<Product> getUserCartItems() {
    return userCartItems;
  }

  bool getIsLoading() {
    return isLoading;
  }

  // Add to cart
  void addToCart(Product product) {
    userCartItems.add(product);
  }

  // Remove from cart
  void removeFromCart(Product product) {
    userCartItems.remove(product);
  }

  // clear cart
  void clearCart() {
    userCartItems.clear();
  }

  String get errorMessage => _errorMessage;

  // fetch products from API
  Future<void> fetchProducts() async {
    isLoading = true;
    _errorMessage = "";
    notifyListeners();

    try {
      productsList = await api.fetchProducts();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
