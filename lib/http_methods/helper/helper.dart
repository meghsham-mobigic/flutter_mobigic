import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helper {
  static logger(String text) {
    print('LOG => $text');
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
      return 'Unknown Error';
    }
  }
}
