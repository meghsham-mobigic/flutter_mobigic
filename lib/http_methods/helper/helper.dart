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

  static String statusCodeData(String stringStatusCode) {
    int statusCode = int.parse(stringStatusCode);
    if (statusCode >= 100 && statusCode < 200) {
      return '$stringStatusCode : Informational';
    } else if (statusCode >= 200 && statusCode < 300) {
      return '$stringStatusCode : Request Successful';
    } else if (statusCode >= 300 && statusCode < 400) {
      return '$stringStatusCode : Request Redirection';
    } else if (statusCode >= 400 && statusCode < 500) {
      return '$stringStatusCode : Client Error';
    } else if (statusCode >= 500 && statusCode < 600) {
      return '$stringStatusCode : Server Error';
    } else {
      return '$stringStatusCode : Unknown Status';
    }
  }

  static ResponseDTO responseDTOConverter(http.Response httpResponse) {
    ResponseDTO responseDTO = ResponseDTO();
    if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
      responseDTO.responseData = httpResponse.body;
      debugPrint('filled with data=>>${responseDTO.responseData}');
    } else {
      responseDTO.error = Helper.statusCodeData(
        httpResponse.statusCode.toString(),
      );
      debugPrint(responseDTO.responseData.isNotEmpty.toString());
      debugPrint('filled with error=>>${responseDTO.error}');
    }
    return responseDTO;
  }
}
