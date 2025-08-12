import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobigic/http_methods/Model/product_model.dart';
import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:flutter_mobigic/http_methods/helper/helper.dart';
import 'package:flutter_mobigic/http_methods/screen/InputBox.dart';
import 'package:flutter_mobigic/http_methods/services/data_service.dart';
import 'package:flutter_mobigic/locator.dart';

class CreateProduct extends StatefulWidget {
  CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final DataService service = locator.get<DataService>();
  // Aniket : Why use locator.get over locator :
  // functionally both code works but
  // .get call Explicitly and makes code more readable
  // final DataService service = locator<DataService>();

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
      body: Container(
        //need more styling
        child: Center(
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
                  ProductModel product = await onSubmit();
                  // debugPrint('=>' + product.id.toString());
                  // debugPrint('=>' + product.id.toString().length.toString());
                  if (product.category != '') {
                    await service.createProduct(product);
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
      await Helper.toast('Category Required');
      return ProductModel.empty();
    }

    ProductModel productModel = ProductModel(
      id: 0,
      title: titleController.text.trim(),
      price: double.parse(priceController.text.trim()),
      description: descriptionController.text.trim(),
      category: categoryController.text.trim(),
      image: imageController.text.trim(),
      rating: 0,
      ratingCount: 0,
    );

    ResponseDTO responseDTO = await service.createProduct(productModel);

    if (responseDTO.responseData.toString().isNotEmpty) {
      final decodedProduct =
          jsonDecode(responseDTO.responseData.toString())
              as Map<String, dynamic>;

      await Helper.snackBar(context, 'Product Created');
      return ProductModel.fromJson(decodedProduct);
    } else {
      await Helper.snackBar(
        context,
        'Error : ${responseDTO.error} Failed to Create Product',
      );
      return ProductModel.empty();
    }
  }
}
