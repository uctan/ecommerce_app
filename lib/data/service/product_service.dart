import 'dart:convert';
import 'dart:ui';

import 'package:app_ecomerce/data/model/product_api.dart';
import 'package:app_ecomerce/data/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ProductService {
  VoidCallback? onPresentProduct;
  List<Product> products = [];
  late Product product;

  void setUpdateListener(VoidCallback onUpdate) {
    onPresentProduct = onUpdate;
  }

  Future<void> getAllProduct() async {
    var url = Uri.parse(
      '${ApiEndPoints.baseUrl + ApiEndPoints.productEndPoints.getAllProduct}',
    );
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (var eachTeam in jsonData['data']) {
        final product = Product(
          id: eachTeam['_id']?.toString(),
          name: eachTeam['name']?.toString(),
          price: eachTeam['price'] is int ? eachTeam['price'] as int : null,
          type: eachTeam['type']?.toString(),
          countInStock: eachTeam['countInStock'] is int
              ? (eachTeam['countInStock'] as int).toDouble()
              : eachTeam['countInStock'] as double?,
          rating: eachTeam['rating'] is int ? eachTeam['rating'] as int : null,
          discount: eachTeam['discount']?.toString(),
          selled: eachTeam['selled'] is int ? eachTeam['selled'] as int : null,
          image: eachTeam['image']?.toString(),
          description: eachTeam['description']?.toString(),
        );
        products.add(product);
      }

      print(products);
      onPresentProduct?.call();
    } else {
      print('fetch product : ${response.statusCode}');
    }
  }

  Future<void> getDetailProduct(String productId) async {
    var url = Uri.parse(
      '${ApiEndPoints.baseUrl + ApiEndPoints.productEndPoints.getProductDetail}/$productId',
    );
    var response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        var jsonData = jsonDecode(response.body);
        // products.clear();
        for (var eachTeam in jsonData['data']) {
          final product = Product(
            id: eachTeam['_id']?.toString(),
            name: eachTeam['name']?.toString(),
            price: eachTeam['price'] is int ? eachTeam['price'] as int : null,
            type: eachTeam['type']?.toString(),
            countInStock: eachTeam['countInStock'] is int
                ? (eachTeam['countInStock'] as int).toDouble()
                : eachTeam['countInStock'] as double?,
            rating:
                eachTeam['rating'] is int ? eachTeam['rating'] as int : null,
            discount: eachTeam['discount']?.toString(),
            selled:
                eachTeam['selled'] is int ? eachTeam['selled'] as int : null,
            image: eachTeam['image']?.toString(),
            description: eachTeam['description']?.toString(),
          );
          products.add(product);
        }

        print(products);
        onPresentProduct?.call();
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  }
}
