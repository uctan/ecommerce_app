import 'package:app_ecomerce/common/config/coloors.dart';
import 'package:app_ecomerce/common/config/constants.dart';

import 'package:app_ecomerce/data/model/product_api.dart';
import 'package:app_ecomerce/data/service/product_service.dart';
import 'package:app_ecomerce/page/quick_food/widget/product_card.dart';
import 'package:app_ecomerce/page/quick_food/widget/product_search_bar.dart';
import 'package:app_ecomerce/page/quick_food/widget/quick_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListFoodPage extends StatefulWidget {
  const ListFoodPage({super.key});

  State<ListFoodPage> createState() => _ListFoodPageState();
}

class _ListFoodPageState extends State<ListFoodPage> {
  final ProductService _productService = ProductService();
  List<Product> _product = [];
  bool isLoading = true;
  Future<void> _fetchProducts() async {
    _productService.setUpdateListener(() {
      setState(() {
        _product = _productService.products;
        isLoading = false;
        print('Product count: ${_product.length}');
      });
    });
    await _productService.getAllProduct();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuickScreenAppbar(),
              const SizedBox(height: 20),
              ProductSearchBar(),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    if (isLoading) {
                      return ProductCard(
                        product: Product(),
                        isLoading: true,
                      );
                    } else {
                      return ProductCard(
                        product: _product[index],
                        isLoading: false,
                      );
                    }
                  },
                  itemCount: isLoading ? 6 : _product.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
