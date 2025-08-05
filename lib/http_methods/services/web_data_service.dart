import 'package:flutter_mobigic/constants/app_string_constants.dart';
import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:flutter_mobigic/http_methods/helper/helper.dart';
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
