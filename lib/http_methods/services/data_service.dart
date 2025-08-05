import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:http/http.dart' as http;

abstract class DataService {
  Future<ResponseDTO> createProduct(Map<String, dynamic> values);

  Future<ResponseDTO> readAllProduct();

  Future<http.Response> updateProduct(Map<String, dynamic> values);

  Future<void> deleteProduct(int productId);
}
