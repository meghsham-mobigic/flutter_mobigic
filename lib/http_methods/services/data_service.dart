import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';

abstract class DataService {
  Future<ResponseDTO> createProduct(Map<String, dynamic> values);

  Future<ResponseDTO> readAllProduct();

  Future<ResponseDTO> updateProduct(Map<String, dynamic> values);

  Future<ResponseDTO> deleteProduct(int productId);
}
