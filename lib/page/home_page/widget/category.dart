import 'package:app_ecomerce/common/config/constants.dart';
import 'package:app_ecomerce/data/model/product_api.dart';
import 'package:app_ecomerce/widget/shimmer_loading_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({
    super.key,
    required this.currentCat,
    required this.product,
    this.isLoading = true,
    this.loadingItemCount = 3,
  });
  final bool isLoading;
  final String currentCat;
  final List<Product> product;
  final int loadingItemCount;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Row(
        children: List.generate(
          loadingItemCount,
          (index) => Container(
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.grey.shade300, // Màu giả lập loading
              borderRadius: BorderRadius.circular(25),
            ),
            width: 80,
            height: 30,
          ),
        ),
      );
    }
    final types = product
        .map((product) => product.type)
        .where((type) => type != null)
        .toSet()
        .toList();
    print('Types: $types');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          types.length,
          (index) => Container(
            decoration: BoxDecoration(
              color: currentCat == types[index] ? kprimaryColor : ksearchColor,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            margin: EdgeInsets.only(right: 15),
            child: Text(
              types[index]!,
              style: TextStyle(
                color: currentCat == types[index]
                    ? Colors.white
                    : Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
