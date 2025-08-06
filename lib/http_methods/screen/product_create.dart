import 'dart:convert';

import 'package:flutter/material.dart';
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
  TextEditingController idController = TextEditingController();
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
                label: 'ID',
                controller: idController,
                isRequired: true,
                isNumber: true,
              ),
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
                  Map<String, dynamic> values = await onSubmit();
                  await service.createProduct(values);
                  Navigator.pop(context);
                  Navigator.pop(context);
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
    idController.dispose();
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> onSubmit() async {
    Map<String, dynamic> values = {};
    if (idController.text.isEmpty || categoryController.text.isEmpty) {
      Helper.toast('ID & Category Required');
    }
    values.addAll({
      'id': idController.text.trim(),
      'title': titleController.text.trim(),
      'price': priceController.text.trim(),
      'description': descriptionController.text.trim(),
      'image': imageController.text.trim(),
      'category': categoryController.text.trim(),
    });

    // debugPrint(values.toString());

    ResponseDTO responseDTO = await service.createProduct(values);

    if (responseDTO.responseData != null) {
      final decodedProduct =
          jsonDecode(responseDTO.responseData.toString())
              as Map<String, dynamic>;
      await Helper.toast('Product Created');
      return decodedProduct;
    } else {
      throw Exception(
        'Failed to create product. Status code: ${Helper.statusCodeData(int.parse(responseDTO.error))}',
      );
    }
  }
}
