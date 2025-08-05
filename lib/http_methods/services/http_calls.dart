import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class HttpCalls {
  static Future<ResponseDTO> getAll(
    String path,
    Map<String, String> headers,
  ) async {
    debugPrint('getAll method called on $path with $headers');

    http.Response httpResponse = await http.get(
      Uri.parse(path),
      headers: headers,
    );
    ResponseDTO responseDTO = ResponseDTO();

    if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
      responseDTO
        ..responseData = httpResponse.body
        ..statusData = httpResponse.statusCode.toString();
    }
    return responseDTO;
  }

  static Future<ResponseDTO> create(
    String path,
    Map<String, String> headers,
    Map<String, dynamic> jsonMap,
  ) async {
    http.Response httpResponse = await http.post(
      Uri.parse(path),
      headers: headers,
      body: jsonEncode(jsonMap),
    );

    ResponseDTO responseDTO = ResponseDTO();

    if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
      responseDTO
        ..responseData = httpResponse.body
        ..statusData = httpResponse.statusCode.toString();
    }
    return responseDTO;
  }

  // Method to update existing resource
  static Future<ResponseDTO> update(
    String path,
    int id,
    Map<String, String> headers,
    Map<String, dynamic> jsonMap,
  ) async {
    http.Response httpResponse = await http.put(
      Uri.parse('$path/$id'),
      headers: headers,
      body: jsonEncode(jsonMap),
    );

    ResponseDTO responseDTO = ResponseDTO();

    if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
      responseDTO.responseData = httpResponse.body;
    } else {
      responseDTO.statusData = httpResponse.statusCode.toString();
    }
    return responseDTO;
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

  static Future<ResponseDTO> postForImage(
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
      return ResponseDTO(
        responseData: jsonDecode(response.body),
        statusData: '',
      );
    } else {
      return ResponseDTO(
        responseData: null,
        statusData: 'Failed with status: ${response.statusCode}',
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
