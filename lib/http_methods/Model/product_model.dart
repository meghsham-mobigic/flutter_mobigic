class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;
  final int ratingCount;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
    
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final ratingData = json['rating'] ?? {};

    return ProductModel(
      id: int.parse(json['id'].toString()),
      title: json['title'] as String? ?? 'default title',
      price: double.parse(json['price'].toString()),
      description: json['description'] as String? ?? 'default description',
      category: json['category'] as String? ?? 'default category',
      image: json['image'] as String? ?? 'default image',
      rating: (ratingData['rate'] as num?)?.toDouble() ?? 0.0,
      ratingCount: (ratingData['count'] as num?)?.toInt() ?? 0,
    );
  }
}
