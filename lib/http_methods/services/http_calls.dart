import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_mobigic/http_methods/Model/http_call_response.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class HttpCalls {
  // Method to make get call for all resources
  static Future<http.Response> getAll(
    String path,
    Map<String, String> headers,
  ) async {
    debugPrint('getAll method called on $path with $headers');
    return http.get(Uri.parse(path), headers: headers);
  }

  // Method to make get call for all resources
  static Future<HttpCallResponse> getAllResponseData(
    String path,
    Map<String, String> headers,
  ) async {
    debugPrint('getAll method called on $path with $headers');
    http.Response response = await http.get(Uri.parse(path), headers: headers);

    HttpCallResponse httpCallResponse = HttpCallResponse();
    if (response.statusCode == 200 || response.statusCode == 201) {
      httpCallResponse.responseData = response.body;
    } else {
      httpCallResponse.errorData = response.statusCode.toString();
    }
    return httpCallResponse;
  }

  static Future<http.Response> create(
    String path,
    Map<String, String> headers,
    Map<String, dynamic> jsonMap,
  ) async {
    return http.post(
      Uri.parse(path),
      headers: headers,
      body: jsonEncode(jsonMap),
    );
  }

  // Method to update existing resource
  static Future<http.Response> update(
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
  static Future<http.Response> delete(
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

  static Future<HttpCallResponse> postForImage(
    String url, {
    dynamic data,
    Uint8List? fileBytes,
    String? fileName,
  }) async {
    http.Response response;

    if (fileBytes != null && fileName != null) {
      String? mimeType = lookupMimeType(fileName);
      MediaType? mediaType = mimeType != null
          ? MediaType.parse(mimeType)
          : null;

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          fileBytes,
          filename: fileName,
          contentType: mediaType,
        ),
      );

      if (data != null) {
        data.forEach((key, value) {
          request.fields[key.toString()] = value.toString();
        });
      }

      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return HttpCallResponse(
        responseData: jsonDecode(response.body),
        errorData: '',
      );
    } else {
      return HttpCallResponse(
        responseData: null,
        errorData: 'Failed with status: ${response.statusCode}',
      );
    }
  }

  // static Future<http.Response> put(
  //   String path,
  //   Map<String, String> headers,
  //   Map<String, dynamic> jsonMap,
  // ) async {
  //   debugPrint(
  //     'update method called on $path with $jsonMap and $headers ',
  //   );
  //   return http.put(
  //     Uri.parse(path),
  //     headers: headers,
  //     body: jsonEncode(jsonMap),
  //   );
  // }
}
