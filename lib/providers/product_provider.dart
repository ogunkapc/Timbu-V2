import 'package:flutter/material.dart';
import 'package:timbu_v2/model/product.dart';
import 'package:timbu_v2/service/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final TimbuApi api;
  ProductProvider({required this.api});

  bool isLoading = false;
  String _errorMessage = '';
  List<Product> productsList = [];
  List<Product> recentlyViewedProducts = [];

  // get list of products
  List<Product> getProductsList() {
    return productsList;
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
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<Product> filterProductsByCategory(String categoryName) {
    return productsList.where((product) {
      return product.categories
          .any((category) => category.name == categoryName);
    }).toList();
  }

  // add product to recently viewed when viewed
  void addToRecentlyViewedList(Product product) {
    recentlyViewedProducts.add(product);
    notifyListeners();
  }

  //! products filter methods for sections
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
    return filterProductsByCategory('recently viewed');
  }
}
