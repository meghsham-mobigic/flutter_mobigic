import 'package:flutter/material.dart';
import 'package:flutter_mobigic/constants/app_colors.dart';
import 'package:flutter_mobigic/http_methods/Model/product_model.dart';
import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:flutter_mobigic/http_methods/helper/helper.dart';
import 'package:flutter_mobigic/http_methods/services/data_service.dart';
import 'package:flutter_mobigic/locator.dart';
import 'package:flutter_mobigic/routes/app_routes.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({required this.product, super.key});
  final ProductModel product;
  final DataService service = locator.get<DataService>();

  @override
  Widget build(BuildContext context) {
    // Example: treating id == 0 as default product
    if (product.id == 0) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Column(
            children: [
              Icon(
                Icons.error,
                size: 100,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 200,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported, size: 100),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 10),
            Text(
              'Category: ${product.category}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(product.description),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.star, color: AppColors.orange),
                const SizedBox(width: 6),
                Text('${product.rating.rate} (${product.rating.count})'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 50,
              children: [
                ElevatedButton(
                  //use of navigation 1.0 named method :
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.updateProduct,
                      arguments: product,
                    );
                  },
                  child: const Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () async => {
                    onDelete(product.id.toString(), context),
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onDelete(String id, BuildContext context) async {
    ResponseDTO responseDTO = await service.deleteProduct(id);

    if (responseDTO.responseData.toString().isNotEmpty) {
      if (responseDTO.responseData == 'null') {
        await Helper.snackBar(
          context,
          'Product Id $id Unavailable',
        );
        Navigator.pop(context);
        return;
      } else {
        await Helper.snackBar(
          context,
          'Product Deleted Successfully ',
        );
        return;
      }
    } else {
      await Helper.snackBar(
        context,
        'Error : ${responseDTO.error} Product Not Deleted',
      );
    }
  }
}
