import 'dart:typed_data';

import 'package:flutter_mobigic/constants/app_string_constants.dart';
import 'package:flutter_mobigic/http_methods/Model/product_model.dart';
import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:flutter_mobigic/http_methods/services/data_service.dart';
import 'package:flutter_mobigic/http_methods/services/http_calls.dart';

class WebDataService implements DataService {
  Map<String, String> headers = {
    'content-type': 'application/json; charset=utf-8',
  };

  HttpCalls caller = HttpCalls();

  @override
  Future<ResponseDTO> createProduct(ProductModel product) async {
    return HttpCalls.postRequest(
      ApiConstants.fakeProductBasePath,
      headers,
      product,
    );
  }

  @override
  Future<ResponseDTO> readAllProduct() async {
    return HttpCalls.getRequest(
      ApiConstants.fakeProductBasePath,
      headers,
    );
  }

  @override
  Future<ResponseDTO> readProduct(int identifier) {
    return HttpCalls.getRequest(
      ApiConstants.fakeProductBasePath,
      headers,
      id: identifier,
    );
  }

  @override
  Future<ResponseDTO> updateProduct(Map<String, dynamic> values) async {
    return HttpCalls.patchRequest(
      ApiConstants.fakeProductBasePath,
      int.parse(values['id'].toString()),
      headers,
      values,
    );
  }

  @override
  Future<ResponseDTO> deleteProduct(int id) async {
    return HttpCalls.deleteRequest(
      ApiConstants.fakeProductBasePath,
      headers,
      id,
    );
  }

  @override
  Future<ResponseDTO> multiPartFileUpload(
    String url, {
    dynamic data,
    Uint8List? fileBytes,
    String? fileName,
  }) {
    return HttpCalls.multipartFileRequest(
      url,
      data: data,
      fileBytes: fileBytes,
      fileName: fileName,
    );
  }
}
