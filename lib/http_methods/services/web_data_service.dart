import 'dart:convert';

import 'package:flutter_mobigic/constants/app_string_constants.dart';
import 'package:flutter_mobigic/http_methods/Model/product_model.dart';
import 'package:flutter_mobigic/http_methods/helper/helper.dart';
import 'package:flutter_mobigic/http_methods/services/data_service.dart';
import 'package:flutter_mobigic/http_methods/services/http_calls.dart';
import 'package:http/http.dart' as http;

class WebDataService implements DataService {
  Map<String, String> headers = {
    'content-type': 'application/json; charset=utf-8',
  };

  HttpCalls caller = HttpCalls();

  @override
  Future<http.Response> createProduct(Map<String, dynamic> values) async {
    final response = await HttpCalls.create(
      ApiConstants.fakeProductBasePath,
      headers,
      values,
    );

    if (response.statusCode == 200) {
      final decodedProduct = jsonDecode(response.body) as Map<String, dynamic>;
      await Helper.toast('Product Created');
      return response;
    } else {
      throw Exception(
        'Failed to create product. Status code: ${response.statusCode}',
      );
    }
  }

  // Method to collect all product from api endpoint -> working
  @override
  Future<List<ProductModel>> realAllProduct() async {
    final response = await HttpCalls.getAll(
      ApiConstants.fakeProductBasePath,
      headers,
    );

    if (response.statusCode == 200) {
      final decodedList = jsonDecode(response.body) as List<dynamic>;

      final List<ProductModel> products = decodedList
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return products;
    } else {
      throw Exception(
        'Failed to load products. Status code: ${response.statusCode}',
      );
    }
  }

  @override
  Future<http.Response> updateProduct(Map<String, dynamic> values) async {
    final response = await HttpCalls.update(
      ApiConstants.fakeProductBasePath,
      int.parse(values['id'].toString()),
      headers,
      values,
    );

    if (response.statusCode == 200) {
      final decodedProduct = jsonDecode(response.body) as Map<String, dynamic>;
      return response;
    } else {
      throw Exception(
        'Failed to updated product. Status code: ${response.statusCode}',
      );
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    final response = await HttpCalls.delete(
      ApiConstants.fakeProductBasePath,
      headers,
      id,
    );

    if (response.statusCode == 200) {
      Helper.logger('Product Deleted');
      await Helper.toast('Product Deleted');
    } else {
      throw Exception(
        'Failed to delete product. Status code: ${response.statusCode}',
      );
    }
    return;
  }
}
