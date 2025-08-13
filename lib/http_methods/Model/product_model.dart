import 'package:flutter_mobigic/http_methods/Model/rating_model.dart';

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  /// Create from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] as String? ?? 'default title',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'] as String? ?? 'default description',
      category: json['category'] as String? ?? 'default category',
      image: json['image'] as String? ?? 'default image',
      rating: json['rating'] != null
          ? Rating.fromJson(json['rating'] as Map<String, dynamic>)
          : Rating.empty(),
    );
  }

  /// Empty/default product
  factory ProductModel.empty() => ProductModel(
    id: 0,
    title: '',
    price: 0.0,
    description: '',
    category: '',
    image: '',
    rating: Rating.empty(),
  );

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }

  @override
  String toString() {
    return 'ProductModel('
        'id: $id, '
        'title: $title, '
        'price: $price, '
        'description: $description, '
        'category: $category, '
        'image: $image, '
        'rating: ${rating.rate} / ${rating.count}'
        ')';
  }
}
