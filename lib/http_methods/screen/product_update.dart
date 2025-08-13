import 'package:flutter/material.dart';
import 'package:flutter_mobigic/http_methods/Model/product_model.dart';
import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:flutter_mobigic/http_methods/helper/helper.dart';
import 'package:flutter_mobigic/http_methods/screen/input_box.dart';
import 'package:flutter_mobigic/http_methods/services/data_service.dart';
import 'package:flutter_mobigic/locator.dart';

class UpdateProduct extends StatefulWidget {
  UpdateProduct({super.key, required this.product});
  final ProductModel product;

  @override
  State<UpdateProduct> createState() => _UpdateProductState(product);
}

class _UpdateProductState extends State<UpdateProduct> {
  _UpdateProductState(this.product);
  ProductModel product;
  final DataService service = locator.get<DataService>();
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
              isNumber: true,
              isDisabled: true,
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
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await onUpdate(0);
              },
              child: const Text('Update With Patch Request'),
            ),

            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await onUpdate(1);
              },
              child: const Text('Update With Put Request'),
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

  Future<void> onUpdate(int requestType) async {
    if (idController.text.isEmpty || categoryController.text.isEmpty) {
      await Helper.toast('Category Required');
      return;
    }

    // Map removed and then used Product model
    ProductModel productModel = ProductModel(
      id: int.parse(idController.text),
      title: idController.text.trim(),
      price: double.parse(priceController.text.trim()),
      description: descriptionController.text.trim(),
      category: categoryController.text.trim(),
      image: imageController.text.trim(),
      rating: product.rating,
    );
    ResponseDTO responseDTO;

    if (requestType == 1) {
      responseDTO = await service.updateProductWithPatch(productModel);
    } else {
      responseDTO = await service.updateProductWithPut(productModel);
    }

    if (responseDTO.responseData.toString().isNotEmpty) {
      // debugPrint(responseDTO.responseData.toString());
      // Map<String, dynamic> decodedMap =
      //     jsonDecode(responseDTO.responseData.toString())
      //         as Map<String, dynamic>;

      await Helper.snackBar(
        context,
        '${requestType == 0 ? 'Updated Product With Patch Request' : 'Updated Product With Put Request'} Successful',
      );
      Navigator.pop(context);
      return;
    } else {
      await Helper.snackBar(
        context,
        'Error : ${responseDTO.error} '
        '${requestType == 0 ? 'Product Not Updated With Patch Request' : 'Product Not Updated With Put Request'} Successful',
      );
    }
  }
}
