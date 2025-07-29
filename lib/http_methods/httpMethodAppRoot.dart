// import 'package:flutter/material.dart';
// import 'package:flutter_mobigic/http_methods/services/data_service.dart';
// import 'package:flutter_mobigic/http_methods/services/web_data_service.dart';

// class Httpmethodapproot extends StatefulWidget {
//   Httpmethodapproot({super.key});

//   @override
//   State<Httpmethodapproot> createState() => _HttpmethodapprootState();
// }

// class _HttpmethodapprootState extends State<Httpmethodapproot> {
//   DataService dataService = WebDataService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('HTTP Methods'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: dataService.getAllProduct,
//             child: const Center(
//               child: Text(
//                 'Make Request',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
