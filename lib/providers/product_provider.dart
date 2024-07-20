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
  String _searchQuery = '';

  // get list of products
  List<Product> getProductsList() {
    return productsList;
  }

  bool getIsLoading() {
    return isLoading;
  }

  String get errorMessage => _errorMessage;

  String get searchQuery => _searchQuery;

  // fetch products from API
  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      productsList = await api.fetchProducts();
      // filteredProductsList = productsList;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //! Search
  // filter products for search query locally
  void searchProducts(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      filteredProductsList = [];
    } else {
      filteredProductsList = productsList.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  List<Product> filterProductsByCategory(String categoryName) {
    return productsList.where((product) {
      return product.categories
          .any((category) => category.name == categoryName);
    }).toList();
  }

  // Filter products by search query
  void filterProductsBySearchQuery(String query) {
    filteredProductsList = productsList.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }

  // Filter products by search query and fetch if needed
  // Future<void> filterProductsBySearchQuery(String query) async {
  //   if (productsList.isEmpty) {
  //     isLoading = true;
  //     notifyListeners();

  //     try {
  //       productsList = await api.fetchProducts();
  //     } catch (e) {
  //       _errorMessage = e.toString();
  //     } finally {
  //       isLoading = false;
  //       notifyListeners();
  //     }
  //   }

  //   filteredProductsList = productsList.where((product) {
  //     return product.name.toLowerCase().contains(query.toLowerCase());
  //   }).toList();
  //   notifyListeners();
  // }

  // add product to recently viewed when viewed
  void addToRecentlyViewedList(Product product) {
    if (!recentlyViewedProducts.contains(product)) {
      if (recentlyViewedProducts.length >= 5) {
        recentlyViewedProducts.removeAt(0);
      }
      recentlyViewedProducts.add(product);
    }
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
    return recentlyViewedProducts;
  }
}
