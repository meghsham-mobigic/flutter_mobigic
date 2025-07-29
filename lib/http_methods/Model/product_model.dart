class ProductModel {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  String rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    this.image = '',
    this.rating = '',
  });

factory ProductModel.fromJson(Map<dynamic, dynamic> json) {
    return ProductModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'].toString(),
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'].toString(),
      category: json['category'].toString(),
      image: json['image'].toString(),
      rating: json['rating'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating,
    };
  }
}
