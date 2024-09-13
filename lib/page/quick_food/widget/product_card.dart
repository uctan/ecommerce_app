import 'dart:convert';
import 'dart:typed_data';

import 'package:app_ecomerce/data/model/product_api.dart';
import 'package:app_ecomerce/page/detail_page/page/detail_page.dart';
import 'package:app_ecomerce/widget/shimmer_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart'; // Import thư viện intl
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.isLoading = true,
  });
  final Product product;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ShimmerLoading();
    }
    String base64String = product.image ?? '';
    Uint8List decodedBytes = base64Decode(base64String.split(',')[1]);

    //neu 0% thi se khong xuat hien
    // final double? promotition = double.tryParse(product.discount ?? '');
    final bool showPromotion =
        product.discount != null && product.discount! > 0;

    // dinh dang gia tien
    final priceFormatted = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ')
        .format(product.price);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(productID: product.id ?? ''),
          ),
        );
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 0.5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(decodedBytes),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 0, top: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${product.name}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 14,
                            ),
                            Text(
                              '${product.rating}/5',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        )
                      ],
                    ),
                    Text(
                      priceFormatted,
                      style: TextStyle(fontSize: 12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (showPromotion) ...{
                          Text(
                            '${product.discount}%',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        },
                        Text(
                          'Quantity: ${product.countInStock}',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
