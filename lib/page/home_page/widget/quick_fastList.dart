import 'dart:convert';
import 'dart:typed_data';

import 'package:app_ecomerce/data/model/product_api.dart';
import 'package:app_ecomerce/widget/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

class QuickAndFastList extends StatelessWidget {
  final List<Product> products;
  final bool isLoading;
  const QuickAndFastList({
    super.key,
    required this.products,
    this.isLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ShimmerLoading();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(products.length, (index) {
          String base64String = products[index].image ?? '';
          Uint8List decodedBytes = base64Decode(base64String.split(',')[1]);
          return Container(
            margin: const EdgeInsets.only(right: 10),
            width: 200,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: MemoryImage(decodedBytes),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      products[index].name ?? '',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Iconsax.dollar_circle,
                          size: 18,
                        ),
                        Text(
                          "${products[index].price} VNĐ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Iconsax.discount_shape,
                          size: 18,
                        ),
                        Text(
                          "${products[index].discount}% ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
