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

  Future<ResponseDTO> readProduct(String identifier);

  Future<ResponseDTO> updateProductWithPatch(ProductModel product);

  Future<ResponseDTO> updateProductWithPut(ProductModel product);

  Future<ResponseDTO> deleteProduct(String productId);
}
