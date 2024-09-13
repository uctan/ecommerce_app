import 'package:app_ecomerce/common/config/coloors.dart';
import 'package:app_ecomerce/common/config/constants.dart';

import 'package:app_ecomerce/data/model/product_api.dart';
import 'package:app_ecomerce/data/service/product_service.dart';
import 'package:app_ecomerce/page/quick_food/widget/product_card.dart';
import 'package:app_ecomerce/page/quick_food/widget/product_search_bar.dart';
import 'package:app_ecomerce/page/quick_food/widget/quick_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListProductPromotion extends StatefulWidget {
  const ListProductPromotion({super.key});

  State<ListProductPromotion> createState() => _ListProductPromotionState();
}

class _ListProductPromotionState extends State<ListProductPromotion> {
  final ProductService _productService = ProductService();
  List<Product> _product = [];
  List<Product> _discountedProducts = [];
  bool isLoading = true;
  Future<void> _fetchProducts() async {
    await _productService.getAllProduct();
    if (mounted) {
      setState(() {
        _product = _productService.products;
        _discountedProducts =
            _product.where((product) => product.discount != 0).toList();
        isLoading = false;
        print('Product count with discount: ${_discountedProducts.length}');
      });
    }
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
              QuickScreenAppbar(
                text: 'Promotion Products',
              ),
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
                        product: _discountedProducts[index],
                        isLoading: false,
                      );
                    }
                  },
                  itemCount: isLoading ? 6 : _discountedProducts.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
