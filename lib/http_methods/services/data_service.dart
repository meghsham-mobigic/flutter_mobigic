import 'package:flutter_mobigic/http_methods/Model/product_model.dart';

abstract class DataService {
  
  // get all product
  Future<List<ProductModel>> getAllProduct(); // get if specific prodcut

  // Future<String> performHttpPUT(String path ); // this will need Product Object if id exist then overide it or create new one
  // Future<String> performHttpPOST(String path); // this will need Product , create new product
  // Future<String> performHttpDELETE(String path); // this will need Product id, if if exist, delete it
  // Future<String> performHttpPATCH(String path); //  this will need Product id, updating key value, if key is there set ne value
}
