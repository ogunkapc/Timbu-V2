import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:timbu_v2/keys.dart';
import 'package:timbu_v2/model/product.dart';

class TimbuApi {
  static const String baseUrl = 'https://api.timbu.cloud';
  final String apiKey = ApiKeys.apiKey;
  final String appId = ApiKeys.appID;
  final String orgId = ApiKeys.organisationID;

  Future<List<Product>> fetchProducts(
      {int page = 1, int size = 20, bool reverseSort = false}) async {
    final url = Uri.parse(
        '$baseUrl/products?organization_id=$orgId&reverse_sort=$reverseSort&page=$page&size=$size&Appid=$appId&Apikey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['items'] == null) {
        throw Exception('No products found');
      }
      List<dynamic> productsData = jsonResponse['items'];
      return productsData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products: ${response.reasonPhrase}');
    }
  }

  // Future<List<Product>> fetchProductsByCategory(String categoryId) async {
  //   final url = Uri.parse(
  //       '$baseUrl/categories/$categoryId/model_type="products"/entities?organization_id=$orgId&Appid=$appId&Apikey=$apiKey');

  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonResponse = json.decode(response.body);
  //     print(
  //         'Products fetched for category $categoryId: ${jsonResponse.length}');
  //     return jsonResponse.map((json) => Product.fromJson(json)).toList();
  //   } else {
  //     print(
  //         'Failed to load products for category $categoryId: ${response.statusCode}');
  //     throw Exception('Failed to load products for category $categoryId');
  //   }
  // }
}
