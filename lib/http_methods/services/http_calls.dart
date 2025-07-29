import 'package:http/http.dart' as http;

class HttpCalls {
  Future<http.Response> getAllRequest(String basepath) async {
    return http.get(Uri.parse(basepath));
  }
}
