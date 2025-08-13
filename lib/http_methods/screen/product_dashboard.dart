import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobigic/http_methods/Model/product_model.dart';
import 'package:flutter_mobigic/http_methods/Model/response_dto.dart';
import 'package:flutter_mobigic/http_methods/helper/helper.dart';
import 'package:flutter_mobigic/http_methods/services/data_service.dart';
import 'package:flutter_mobigic/locator.dart';
import 'package:flutter_mobigic/routes/app_routes.dart';

class ProductDashboard extends StatefulWidget {
  const ProductDashboard({super.key});

  @override
  State<ProductDashboard> createState() => _ProductDashboard();
}

class _ProductDashboard extends State<ProductDashboard> {
  final DataService service = locator.get<DataService>();
  ResponseDTO responseDTO = ResponseDTO();

  Future<List<ProductModel>> getAllProductsDetails() async {
    debugPrint(
      'product_dashboard.dart : getAllProductsDetails() : Call to get all products',
    );
    responseDTO = await service.readProduct('');
    if (responseDTO.responseData.toString().isNotEmpty) {
      final List<dynamic> decodedList =
          jsonDecode(responseDTO.responseData.toString()) as List<dynamic>;

      return decodedList
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<ProductModel> getProductDetails(String id) async {
    // debugPrint(
    //   'product_dashboard.dart : getAllProductsDetails() : Call to get a productID $id',
    // );

    responseDTO = await service.readProduct(id);

    if (responseDTO.responseData.toString().isNotEmpty) {
      return ProductModel.fromJson(
        jsonDecode(responseDTO.responseData.toString()) as Map<String, dynamic>,
      );
    }

    await Helper.snackBar(context, 'Unable Product Unable');
    return ProductModel.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addProduct);
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: getAllProductsDetails(),
        builder: (context, productsData) {
          if (productsData.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (responseDTO.error.toString().isNotEmpty) {
            return Center(
              child: Column(
                children: [
                  Text(
                    '${responseDTO.error} ',
                  ),
                  const Icon(
                    Icons.error,
                    size: 100,
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: productsData.data!.length,
              itemBuilder: (context, index) {
                final ProductModel product = productsData.data![index];
                return Card(
                  elevation: 10,
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.network(
                          product.image,
                          height: 80,
                          width: 80,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Title : ${product.title}',
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Category : ${product.category}',
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Price : ₹ ${product.price}',
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${product.rating.rate} / '
                                    '${product.rating.count} Ratings',
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () async {
                                  final ProductModel selectedProduct =
                                      await getProductDetails(
                                        product.id.toString(),
                                      );
                                  if (selectedProduct.id != 0) {
                                    await Navigator.pushNamed(
                                      context,
                                      AppRoutes.detailsProduct,
                                      arguments: selectedProduct,
                                    );
                                  }
                                },
                                child: const Text('View Details'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
