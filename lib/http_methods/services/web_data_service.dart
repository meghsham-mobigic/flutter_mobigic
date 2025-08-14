import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
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
  Future<ResponseDTO> createProduct(ProductModel productBody) async {
    return HttpCalls.performHTTPPOST(
      ApiConstants.fakeProductBasePath,
      headers,
      productBody,
    );
  }

  @override
  Future<ResponseDTO> readProduct(String id) {
    final String path = '${ApiConstants.fakeProductBasePath}/$id';
    return HttpCalls.performHTTPGET(
      path,
      headers,
    );
  }

  @override
  Future<ResponseDTO> updateProductWithPatch(ProductModel product) async {
    final String path = '${ApiConstants.fakeProductBasePath}/${product.id}';
    debugPrint('web_data_service.dart : PATCH $path');
    return HttpCalls.performHTTPPATCH(
      path,
      headers,
      product,
    );
  }

  @override
  Future<ResponseDTO> updateProductWithPut(ProductModel product) async {
    final String path = '${ApiConstants.fakeProductBasePath}/${product.id}';
    debugPrint('web_data_service.dart : PUT $path');
    return HttpCalls.performHTTPPATCH(
      path,
      headers,
      product,
    );
  }

  @override
  Future<ResponseDTO> deleteProduct(String id) async {
    final String path = '${ApiConstants.fakeProductBasePath}/$id';
    return HttpCalls.performHTTPDELETE(
      path,
      headers,
    );
  }

  @override
  Future<ResponseDTO> multiPartFileUpload(
    String url, {
    dynamic data,
    Uint8List? fileBytes,
    String? fileName,
  }) {
    return HttpCalls.performHTTPPOSTMUTLIPART(
      url,
      data: data,
      fileBytes: fileBytes,
      fileName: fileName,
    );
  }
}
