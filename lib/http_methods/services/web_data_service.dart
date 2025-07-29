

// import 'package:flutter_mobigic/http_methods/services/data_service.dart';
// import 'package:http/http.dart' as http;

// class WebDataService implements DataService  {

//    String basePath = 'https://fakestoreapi.com';

//   Future<String> performHTTPGET(String path) async {
//     return await http.get(Uri.parse('$basePath/$path'));
//   }
  
//   @override
//   Future<String> performHttpDELETE(String path) {
//     // TODO: implement performHttpDELETE
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<String> performHttpGET(String path, String productID) {
//     // TODO: implement performHttpGET
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<String> performHttpPATCH(String path) {
//     // TODO: implement performHttpPATCH
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<String> performHttpPOST(String path) {
//     // TODO: implement performHttpPOST
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<String> performHttpPUT(String path) {
//     // TODO: implement performHttpPUT
//     throw UnimplementedError();
//   }




// }




// // this method is a async method which accepets 
//         // path as string, 
//         // map of query parameter in which query
//         // authtoken 
// Future<DataResponse> performHTTPGET() async {


//   final Uri url = Uri.parse(
//   );

//   final Map<String, String> headers = <String, String>{};

//   final Response response = await get(uri, headers: headers);
//   DataResponse dataResponse;
//   switch (response.statusCode) {
//     case 200:
//       dataResponse = DataResponse(response.body);
//       break;
//     default:
//       break;
//   }

//   return dataResponse;
// }


