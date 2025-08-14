import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobigic/http_methods/Model/product_model.dart';
import 'package:flutter_mobigic/http_methods/Model/rating_model.dart';
import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:flutter_mobigic/http_methods/helper/helper.dart';
import 'package:flutter_mobigic/http_methods/screen/input_box.dart';
import 'package:flutter_mobigic/http_methods/services/data_service.dart';
import 'package:flutter_mobigic/locator.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final DataService service = locator.get<DataService>();
  // Aniket : Why use locator.get over locator :
  // functionally both code works but
  // .get call Explicitly and makes code more readable
  // final DataService service = locator<DataService>();

  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  // get values => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Create Product'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Create Product Form '),
              InputBox(
                label: 'Title',
                controller: titleController,
              ),
              InputBox(
                label: 'Price',
                controller: priceController,
                isNumber: true,
              ),
              InputBox(
                label: 'Description',
                controller: descriptionController,
              ),
              InputBox(
                label: 'Image',
                controller: imageController,
              ),
              InputBox(
                label: 'Category',
                controller: categoryController,
                isRequired: true,
              ),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final ProductModel product = await onSubmit();
                    // debugPrint('product_create.dart => Product : ${product}');
                    // debugPrint('product_create.dart => ' + product.id.toString());
                    // debugPrint('product_create.dart => ' + product.id.toString().length.toString());
                    if (product.category != '') {
                      await service.createProduct(product);
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  Future<ProductModel> onSubmit() async {
    if (categoryController.text.isEmpty) {
      await Helper.snackBar(context, 'Category Required');
      return ProductModel.empty();
    }

    final ProductModel productModel = ProductModel(
      id: 0,
      title: titleController.text.trim(),
      price: double.tryParse(priceController.text) ?? 0.0,
      description: descriptionController.text.trim(),
      category: categoryController.text.trim(),
      image: imageController.text.trim(),
      rating: Rating.empty(),
    );

    final ResponseDTO responseDTO = await service.createProduct(productModel);

    // debugPrint(
    //   'product_create.dart => ResponseDTO.responseData : ${responseDTO.responseData} : ',
    // );
    // debugPrint(
    //   'product_create.dart => ResponseDTO.error : ${responseDTO.error} : ',
    // );

    if (responseDTO.responseData.toString().isNotEmpty) {
      await Helper.snackBar(context, 'Product Created Successfully');

      /*
        as suggested changed to type specific but still not sure to use  as Map<String, dynamic>;
        because the jsonDecode gives dynamic value but i need to convert it in Map<String, dynamic>
        String is key and value can anything that why its dynamic
        debugPrint('product_create.dart =>${decodedProduct.runtimeType.toString()}');
      */

      return ProductModel.fromJson(
        jsonDecode(responseDTO.responseData.toString()) as Map<String, dynamic>,
      );
    } else {
      await Helper.snackBar(
        context,
        'Error : ${responseDTO.error} Failed to Create Product',
      );
      return ProductModel.empty();
    }
  }
}
