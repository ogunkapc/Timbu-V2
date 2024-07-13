import 'package:flutter/material.dart';
import 'package:timbu_v2/model/product.dart';
import 'package:timbu_v2/service/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final TimbuApi api;
  ProductProvider({required this.api});

  bool isLoading = false;
  String _errorMessage = '';
  List<Product> productsList = [];
  List<Product> filteredProductsList = [];
  List<Product> recentlyViewedProducts = [];

  // get list of products
  List<Product> getProductsList() {
    return productsList;
  }

  List<Product> getFilteredProductsList() {
    return filteredProductsList;
  }

  bool getIsLoading() {
    return isLoading;
  }

  String get errorMessage => _errorMessage;

  // fetch products from API
  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      productsList = await api.fetchProducts();
      // initially show all products
      filteredProductsList = productsList;
      // Debugging prints
      print('Fetched Products: ${productsList.length}');
      for (var product in productsList) {
        print(
            'Product: ${product.name}, Categories: ${product.categories.map((c) => c.name).join(', ')}');
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<Product> filterProductsByCategory(String categoryName) {
    return productsList.where((product) {
      return product.categories.any((category) => category.name == categoryName);
    }).toList();
  }

  List<Product> getRecentlyViewedProductsByCategory(String categoryName) {
    return recentlyViewedProducts.where((product) {
      return product.categories.any((category) => category.name == categoryName);
    }).toList();
  }

  // this method is called when a product is viewed
  void addRecentlyViewedProduct(Product product) {
    recentlyViewedProducts.add(product);
    notifyListeners();
  }

  // Filtering methods for sections
  List<Product> getJustForYou() {
    return filterProductsByCategory('just for you');
  }

  List<Product> getDeals() {
    return filterProductsByCategory('deals');
  }

  List<Product> getOurCollections() {
    return filterProductsByCategory('our collections');
  }

  List<Product> getYouMightLike() {
    return filterProductsByCategory('you might like');
  }

  List<Product> getRecentlyViewed() {
    return recentlyViewedProducts;
  }
}
