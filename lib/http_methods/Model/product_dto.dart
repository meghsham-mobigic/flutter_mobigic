import 'package:flutter_mobigic/http_methods/Model/product_model.dart';

class ProductDto {

  factory ProductDto.fromJson(Map<String, String> json) {
    return ProductDto(
      id: int.tryParse(json['id'] ?? '') ?? 0,
      title: json['title'] ?? '',
      price: double.tryParse(json['price'] ?? '') ?? 0.0,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      rating: json['rating'] ?? '',
    );
  }
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final String rating;

  ProductDto({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    this.image = '',
    this.rating = '',
  });

  Map<String, String> toJson() {
    return {
      'id': id.toString(),
      'title': title,
      'price': price.toString(),
      'description': description,
      'category': category,
      'image': image,
      'rating': rating,
    };
  }

  ProductModel toModel() {
    return ProductModel(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating,
    );
  }
}
