import 'dart:convert';
import 'dart:typed_data';

import 'package:app_ecomerce/common/config/constants.dart';
import 'package:app_ecomerce/data/model/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItemProduct extends StatelessWidget {
  const OrderItemProduct({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    final totalPriceFormatted =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ')
            .format(order.totalPrice);

    return Column(
      children: [
        ListView.builder(
          itemCount: order.orderItems?.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final orderItem = order.orderItems?[index];
            if (orderItem == null) {
              return const SizedBox();
            }
            Uint8List? decodedBytes;
            String base64String = orderItem.image;

            if (base64String.isNotEmpty) {
              try {
                decodedBytes = base64Decode(base64String.split(',').last);
              } catch (e) {
                decodedBytes = null;
              }
            }

            // Chuyển đổi price từ String sang double và định dạng giá tiền
            final double? price = double.tryParse(orderItem.price);
            final priceFormatted = price != null
                ? NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ')
                    .format(price)
                : 'Loading';

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  decodedBytes != null
                      ? Image.memory(
                          decodedBytes,
                          width: 130,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/banner2.png',
                          width: 130,
                          height: 100,
                        ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(orderItem.name),
                      ),
                      const SizedBox(height: 5),
                      Text('Số lượng sản phẩm : ${orderItem.amount}'),
                      const SizedBox(height: 5),
                      Text('Giá tiền : $priceFormatted'),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Thành Tiền:',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(width: 2),
            Text(
              totalPriceFormatted,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: kprimaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
