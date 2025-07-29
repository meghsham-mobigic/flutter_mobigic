import 'dart:convert';

import 'package:flutter_mobigic/http_methods/Model/product_model.dart';
import 'package:flutter_mobigic/http_methods/services/data_service.dart';
import 'package:flutter_mobigic/http_methods/services/http_calls.dart';
import 'package:http/http.dart' as http;

class WebDataService implements DataService {
  String basePath = 'https://fakestoreapi.com/products';
  HttpCalls call = HttpCalls();

  @override
  Future<List<ProductModel>> getAllProduct() async {

    List<ProductModel> productList = [];

    // Call the API and get the response as a string
    final response = await call.getAllRequest(basePath);

    // Decode the JSON string into a Dart object
    final jsonData = jsonDecode(response as String);

    // Check if the decoded data is a list
    if (jsonData is List) {
      // Loop through each item and convert to ProductModel
      for (var item in jsonData) {
        productList.add(ProductModel.fromJson(item));
      }
    }

    // Return the list of products
    return productList;
  }


}

    // final Uri url = Uri.parse(basePath);
    // Response response = await get(url);

    // if (response.statusCode == 200) {
    //   final jsonData = json.decode(response.body);
    //   print('===> ${jsonData.runtimeType}');
    //   print('/n/n/');

    //   List<ProductModel> productList;

    //   if (jsonData is List) {
    //     for (var item in jsonData) {
    //       ProductModel.fromJson(item);
    //     }
    //   }
    // } else {
    //   print('Request failed with status: ${response.statusCode}');
    // }





  // Future<DataResponse> performHTTPGET() async {
  //     final Uri url = Uri.parse(basePath);
  //     final Map<String, String> headers = <String, String>{};
  //     final Response response = await get(uri, headers: headers);
  //     DataResponse dataResponse;
  //     switch (response.statusCode) {
  //       case 200:
  //         dataResponse = DataResponse(response.body);
  //         break;
  //       default:
  //         break;
  //     }
  //     return dataResponse;
  //   }

