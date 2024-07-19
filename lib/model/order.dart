import 'package:timbu_v2/model/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantities;
  final double totalAmount;
  final DateTime date;
  

  Order({
    required this.id,
    required this.products,
    required this.quantities,
    required this.totalAmount,
    required this.date,
  });
}
