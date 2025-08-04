import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpCalls {

  // Method to make get call for all resources
  Future<http.Response> getAll(
      String path,
      Map<String, String> headers,
      ) async {
    debugPrint('getAll method called on $path with $headers');
    return http.get(Uri.parse(path), headers: headers);
  }


  Future<http.Response> create(
      String path,
      Map<String, String> headers,
      Map<String, dynamic> jsonMap,
      ) async{
    return http.post(Uri.parse(path),
    headers: headers,
    body: jsonEncode(jsonMap));
  }

  // Method to update existing resource
  Future<http.Response> update(
      String path,
      int id,
      Map<String, String> headers,
      Map<String, dynamic> jsonMap,
      ) async {
    final fullPath = '$path/$id';
    debugPrint(
      'update method called on $fullPath with $jsonMap and $headers',
    );

    final response = await http.put(
      Uri.parse(fullPath),
      headers: headers,
      body: jsonEncode(jsonMap),
    );


    return response;
  }

  // Method to delete resource
  Future<http.Response> delete(
    String path,
    Map<String, String> headers,
    dynamic identifier,
  ) async {
    debugPrint(
      'deleter method called on $path/$identifier with $headers ',
    );
    return http.get(
      Uri.parse('$path/$identifier'),
      headers: headers,
    );
  }

  Future<http.Response> put(
    String path,
    Map<String, String> headers,
    Map<String, dynamic> jsonMap,
  ) async {
    debugPrint(
      'update method called on $path with $jsonMap and $headers ',
    );
    return http.put(
      Uri.parse(path),
      headers: headers,
      body: jsonEncode(jsonMap),
    );

  }


}
