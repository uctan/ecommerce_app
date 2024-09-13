import 'dart:convert';
import 'dart:typed_data';

import 'package:app_ecomerce/data/model/cart_item.dart';
import 'package:app_ecomerce/data/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentProductWidget extends StatelessWidget {
  const PaymentProductWidget({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: cartProvider.cartItems.length,
          itemBuilder: (context, index) {
            final cartItem = cartProvider.cartItems[index];
            final String base64String = cartItem.product.image ?? '';
            final Uint8List decodedBytes =
                base64Decode(base64String.split(',').last);
            final String priceFormatted = NumberFormat.currency(
              locale: 'vi_VN',
              symbol: 'VNĐ',
            ).format(cartItem.product.price ?? 0.0);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Image.memory(
                    decodedBytes,
                    height: 90,
                    width: 90,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        height: 90,
                        width: 90,
                        child: Icon(Icons.error),
                      );
                    },
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.product.name ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        cartItem.quantity.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        priceFormatted,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
