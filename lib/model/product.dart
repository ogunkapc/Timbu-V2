class Product {
  final String id;
  final String name;
  final String description;
  final bool isAvailable;
  final List<String> photos;
  final double? currentPrice;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.isAvailable,
    required this.photos,
    this.currentPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    const String baseImageUrl = 'https://api.timbu.cloud/images/';
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isAvailable: json['is_available'],
      photos: (json['photos'] as List)
          .map((photo) => "$baseImageUrl${photo['url'] as String}")
          .toList(),
      currentPrice: json['current_price'] != null &&
              json['current_price'] is List &&
              (json['current_price'] as List).isNotEmpty
          ? (json['current_price'][0]['NGN'][0] as num).toDouble()
          : null,
    );
  }
}
