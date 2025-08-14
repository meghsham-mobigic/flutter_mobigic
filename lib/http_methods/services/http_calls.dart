import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobigic/http_methods/Model/product_model.dart';
import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:flutter_mobigic/http_methods/helper/helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class HttpCalls {
  // Create
  static Future<ResponseDTO> performHTTPPOST(
    String path,
    Map<String, String> headers,
    ProductModel product, //use of dynamic
  ) async {
    debugPrint('http_calls.dart : POST Request called with $product');
    final http.Response httpResponse = await http.post(
      Uri.parse(path),
      headers: headers,
      body: jsonEncode(product.toJson()),
    );
    return Helper.responseDTOConverter(httpResponse);
  }

  // Read
  static Future<ResponseDTO> performHTTPGET(
    String path,
    Map<String, String> headers,
  ) async {
    debugPrint('http_calls.dart : GET Request called : $path');
    final Uri uri = Uri.parse(path);
    final http.Response httpResponse = await http.get(uri, headers: headers);

    return Helper.responseDTOConverter(httpResponse);
  }

  // Update using put request
  static Future<ResponseDTO> performHTTPPUT(
    String path,
    Map<String, String> headers,
    ProductModel product,
    // String path,
    // int identifier,
    // Map<String, String> headers,
    // Map<String, dynamic> jsonMap,
  ) async {
    debugPrint('http_calls.dart : PUT called with body $product');
    final http.Response httpResponse = await http.put(
      Uri.parse(path),
      headers: headers,
      body: jsonEncode(product.toJson()),
    );
    return Helper.responseDTOConverter(httpResponse);
  }

  // Update using patch request
  static Future<ResponseDTO> performHTTPPATCH(
    String path,
    Map<String, String> headers,
    ProductModel product,
  ) async {
    debugPrint('http_calls.dart : PATCH called with body $product');
    final http.Response httpResponse = await http.patch(
      Uri.parse(path),
      headers: headers,
      body: jsonEncode(product.toJson()),
    );
    return Helper.responseDTOConverter(httpResponse);
  }

  // Delete
  static Future<ResponseDTO> performHTTPDELETE(
    String path,
    Map<String, String> headers,
  ) async {
    debugPrint('http_calls.dart : DELETE Request called with path $path');
    final http.Response httpResponse = await http.delete(
      Uri.parse(path),
      headers: headers,
    );
    return Helper.responseDTOConverter(httpResponse);
  }

  // Multipart File Upload
  static Future<ResponseDTO> performHTTPPOSTMUTLIPART(
    String url, {
    dynamic data,
    Uint8List? fileBytes,
    String? fileName,
  }) async {
    http.Response response;

    if (fileBytes != null && fileName != null) {
      final String? mimeType = lookupMimeType(fileName);
      debugPrint('${mimeType?.length}');
      final MediaType? mediaType = mimeType != null
          ? MediaType.parse(mimeType)
          : null;

      final http.MultipartRequest request = http.MultipartRequest(
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
      final http.StreamedResponse streamedResponse = await request.send();
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
