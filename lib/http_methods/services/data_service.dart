import 'package:flutter_mobigic/http_methods/Model/product_model.dart';
import 'package:http/http.dart' as http;

abstract class DataService {
  Future<http.Response> createProduct(Map<String, dynamic> values);

  Future<List<ProductModel>> realAllProduct();

  Future<http.Response> updateProduct(Map<String, dynamic> values);

  Future<void> deleteProduct(int productId);
}
