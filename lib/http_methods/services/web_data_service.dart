import 'dart:typed_data';

import 'package:flutter_mobigic/constants/app_string_constants.dart';
import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:flutter_mobigic/http_methods/services/data_service.dart';
import 'package:flutter_mobigic/http_methods/services/http_calls.dart';

class WebDataService implements DataService {
  Map<String, String> headers = {
    'content-type': 'application/json; charset=utf-8',
  };

  HttpCalls caller = HttpCalls();

  @override
  Future<ResponseDTO> createProduct(Map<String, dynamic> values) async {
    return await HttpCalls.create(
      ApiConstants.fakeProductBasePath,
      headers,
      values,
    );
  }

  // Method to collect all product from api endpoint -> working
  @override
  Future<ResponseDTO> readAllProduct() async {
    return HttpCalls.getAll(
      ApiConstants.fakeProductBasePath,
      headers,
    );
  }

  @override
  Future<ResponseDTO> updateProduct(Map<String, dynamic> values) async {
    return HttpCalls.update(
      ApiConstants.fakeProductBasePath,
      int.parse(values['id'].toString()),
      headers,
      values,
    );
  }

  @override
  Future<ResponseDTO> deleteProduct(int id) async {
    return HttpCalls.delete(
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
    return HttpCalls.multipartFileUploader(
      url,
      data: data,
      fileBytes: fileBytes,
      fileName: fileName,
    );
  }
}
