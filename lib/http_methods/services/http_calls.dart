import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:flutter_mobigic/http_methods/helper/helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class HttpCalls {
  static Future<ResponseDTO> getAll(
    String path,
    Map<String, String> headers,
  ) async {
    // debugPrint('getAll() gets called in http_calls.dart');
    // debugPrint('getAll method called on $path with $headers');

    http.Response httpResponse = await http.get(
      Uri.parse(path),
      headers: headers,
    );

    ResponseDTO responseDTO = ResponseDTO();

    int statusCode = httpResponse.statusCode;
    // debugPrint(' http_calls.dart=>${statusCode.runtimeType}');
    if (statusCode == 200 || statusCode == 201) {
      responseDTO.responseData = httpResponse.body;
    } else {
      responseDTO.statusData = httpResponse.statusCode.toString();
    }
    return responseDTO;

    // return Helper.responseDTOConverter(httpResponse);
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

    return Helper.responseDTOConverter(httpResponse);
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
    return Helper.responseDTOConverter(httpResponse);
  }

  // Method to delete resource
  static Future<ResponseDTO> delete(
    String path,
    Map<String, String> headers,
    dynamic identifier,
  ) async {
    debugPrint(
      'deleter method called on $path/$identifier with $headers ',
    );
    http.Response httpResponse = await http.get(
      Uri.parse('$path/$identifier'),
      headers: headers,
    );
    return Helper.responseDTOConverter(httpResponse);
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
}
