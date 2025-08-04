import 'package:flutter/material.dart';
import 'package:flutter_mobigic/constants/app_colors.dart';
import 'package:flutter_mobigic/http_methods/Model/product_model.dart';
import 'package:flutter_mobigic/http_methods/screen/product_details.dart';
import 'package:flutter_mobigic/http_methods/services/data_service.dart';
import 'package:flutter_mobigic/http_methods/services/web_data_service.dart';
import 'package:flutter_mobigic/routes/app_routes.dart';

class ProductDashboard extends StatefulWidget {
  const ProductDashboard({super.key});

  @override
  State<ProductDashboard> createState() => _ProductDashboard();
}

class _ProductDashboard extends State<ProductDashboard> {
  final DataService service = WebDataService();

  Future<List<ProductModel>> getAllProductsDetails() async {
    return service.realAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Dashboard'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'New',
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
          } else if (productsData.hasError) {
            return Center(child: Text('Error: ${productsData.error}'));
          }

          return ListView.builder(
            itemCount: productsData.data!.length,
            itemBuilder: (context, index) {
              final product = productsData.data![index];
              //ProductModel product = productsData.data![index];
              
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
                        fit: BoxFit.fitHeight,
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
                                  '${product.rating}, Total RatingsCunt : (${product.ratingCount})',
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ProductDetailScreen(product: product),
                                  ),
                                );
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
        },
      ),
    );
  }
}
