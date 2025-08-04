import 'package:flutter/material.dart';
import 'package:flutter_mobigic/http_methods/Model/product_model.dart';
import 'package:flutter_mobigic/http_methods/helper/helper.dart';
import 'package:flutter_mobigic/http_methods/screen/InputBox.dart';
import 'package:flutter_mobigic/http_methods/services/data_service.dart';
import 'package:flutter_mobigic/http_methods/services/web_data_service.dart';

class UpdateProduct extends StatefulWidget {
  UpdateProduct({super.key, required this.product});
  final ProductModel product;

  @override
  State<UpdateProduct> createState() => _UpdateProductState(product);
}

class _UpdateProductState extends State<UpdateProduct> {
  _UpdateProductState(this.product);
  ProductModel product;
  final DataService service = WebDataService();
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    idController.text = product.id.toString();
    titleController.text = product.title.toString();
    priceController.text = product.price.toString();
    descriptionController.text = product.description.toString();
    imageController.text = product.image.toString();
    categoryController.text = product.category.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            InputBox(
                label: 'ID',
                controller: idController,
                isRequired: true,
                isNumber: true
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
                Map<String, dynamic> values = onUpdate()
                  ..addAll({
                    'id': int.parse(idController.text.trim()),
                    'title': titleController.text.trim(),
                    'price': double.parse(priceController.text.trim()),
                    'description': descriptionController.text.trim(),
                    'image': imageController.text.trim(),
                    'category': categoryController.text.trim(),
                  });
                await service.updateProduct(values);
                await Helper.toast('Updated Product');
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
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

  Map<String, dynamic> onUpdate() {
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

    return values;
  }
}
