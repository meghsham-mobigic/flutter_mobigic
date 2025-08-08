import 'package:flutter/material.dart';
import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Helper {
  static logger(String text) {
    debugPrint('LOG => $text');
  }

  static Future<void> toast(String text) async {
    await Fluttertoast.showToast(msg: text);
  }

  static Future<void> snackBar(BuildContext context, String text) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  static String statusCodeData(int statusCode) {
    if (statusCode >= 100 && statusCode < 200) {
      return 'Informational';
    } else if (statusCode >= 200 && statusCode < 300) {
      return 'Request Successful';
    } else if (statusCode >= 300 && statusCode < 400) {
      return 'Request Redirection';
    } else if (statusCode >= 400 && statusCode < 500) {
      return 'Client Error';
    } else if (statusCode >= 500 && statusCode < 600) {
      return 'Server Error';
    } else {
      return 'Unknown Status';
    }
  }

  static ResponseDTO responseDTOConverter(http.Response httpResponse) {
    ResponseDTO responseDTO = ResponseDTO();

    debugPrint(httpResponse.statusCode.runtimeType.toString());

    if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
      responseDTO.responseData = httpResponse.body;
      print('filled with data');
    } else {
      responseDTO.error = httpResponse.statusCode.toString();

      print('filled with error');
    }

    return responseDTO;
  }
}
