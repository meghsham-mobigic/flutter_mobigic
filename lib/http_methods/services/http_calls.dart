import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:flutter_mobigic/http_methods/helper/helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class HttpCalls {
  // Create
  static Future<ResponseDTO> postRequest(
    String path,
    Map<String, String> headers,
    Map<String, dynamic> jsonBody,
  ) async {
    final http.Response httpResponse = await http.post(
      Uri.parse(path),
      headers: headers,
      body: jsonEncode(jsonBody),
    );
    return Helper.responseDTOConverter(httpResponse);
  }

  // Read
  static Future<ResponseDTO> getRequest(
    String path,
    Map<String, String> headers, {
    int? id,
  }) async {
    String finalPath = id != null ? '$path/${id}' : path;
    final uri = Uri.parse(finalPath);
    final http.Response httpResponse = await http.get(uri, headers: headers);

    return Helper.responseDTOConverter(httpResponse);
  }

  // Update using put request
  static Future<ResponseDTO> putRequest(
    String path,
    int identifier,
    Map<String, String> headers,
    Map<String, dynamic> jsonMap,
  ) async {
    final http.Response httpResponse = await http.put(
      Uri.parse('$path/$identifier'),
      headers: headers,
      body: jsonEncode(jsonMap),
    );
    return Helper.responseDTOConverter(httpResponse);
  }

  // Update using patch request
  static Future<ResponseDTO> patchRequest(
    String path,
    int identifier,
    Map<String, String> headers,
    Map<String, dynamic> jsonMap,
  ) async {
    final http.Response httpResponse = await http.patch(
      Uri.parse('${path}/$identifier'),
      headers: headers,
      body: jsonEncode(jsonMap),
    );
    return Helper.responseDTOConverter(httpResponse);
  }

  // Delete
  static Future<ResponseDTO> deleteRequest(
    String path,
    Map<String, String> headers,
    dynamic identifier,
  ) async {
    final http.Response httpResponse = await http.delete(
      Uri.parse('$path/$identifier'),
      headers: headers,
    );
    return Helper.responseDTOConverter(httpResponse);
  }

  // Multipart File Upload
  static Future<ResponseDTO> multipartFileRequest(
    String url, {
    dynamic data,
    Uint8List? fileBytes,
    String? fileName,
  }) async {
    http.Response response;

    if (fileBytes != null && fileName != null) {
      String? mimeType = lookupMimeType(fileName);
      print(mimeType?.length.toString());
      MediaType? mediaType = mimeType != null
          ? MediaType.parse(mimeType)
          : null;

      http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
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
      http.StreamedResponse streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
    }
    return Helper.responseDTOConverter(response);
  }
}
