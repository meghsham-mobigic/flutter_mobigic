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
}
