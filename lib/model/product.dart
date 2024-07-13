class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Product {
  final String id;
  final String uniqueId;
  final String name;
  final String description;
  final bool isAvailable;
  final List<String> photos;
  final double? currentPrice;
  final List<Category> categories;

  Product({
    required this.id,
    required this.uniqueId,
    required this.name,
    required this.description,
    required this.isAvailable,
    required this.photos,
    this.currentPrice,
    required this.categories,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    const String baseImageUrl = 'https://api.timbu.cloud/images/';
    // List<String> categoryNames = (json['categories'] as List).map((category) => category['name'] as String).toList();

    return Product(
      id: json['id'],
      uniqueId: json['unique_id'],
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
      categories: (json['categories'] as List)
          .map((category) => Category.fromJson(category))
          .toList(),
    );
  }
}
