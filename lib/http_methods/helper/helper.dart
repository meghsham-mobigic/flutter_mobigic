import 'package:fluttertoast/fluttertoast.dart';

class Helper {
  static logger(String text) {
    print('LOG => $text');
  }

  static Future<void> toast(String text) async {
     await Fluttertoast.showToast(
      msg: 'note saved'
    );
  }
}

