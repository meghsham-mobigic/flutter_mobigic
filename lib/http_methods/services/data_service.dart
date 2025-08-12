import 'dart:typed_data';

import 'package:flutter_mobigic/http_methods/Model/product_model.dart';
import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';

abstract class DataService {
  Future<ResponseDTO> createProduct(ProductModel productModel);

  Future<ResponseDTO> multiPartFileUpload(
    String url, {
    dynamic data,
    Uint8List? fileBytes,
    String? fileName,
  });

  Future<ResponseDTO> readAllProduct();

  Future<ResponseDTO> readProduct(int identifier);

  Future<ResponseDTO> updateProduct(Map<String, dynamic> values);

  Future<ResponseDTO> deleteProduct(int productId);
}
