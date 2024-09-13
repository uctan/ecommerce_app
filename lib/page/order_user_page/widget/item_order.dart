import 'dart:convert';
import 'dart:typed_data';

import 'package:app_ecomerce/common/config/constants.dart';
import 'package:app_ecomerce/data/model/order.dart';
import 'package:app_ecomerce/page/order_user_page/page/detail_order_user_page.dart';
import 'package:app_ecomerce/page/order_user_page/widget/item_order_product.dart';
import 'package:flutter/material.dart';

class ItemOrder extends StatelessWidget {
  const ItemOrder({
    super.key,
    required this.order,
  });
  final Order order;

  @override
  Widget build(BuildContext context) {
    print('coi order ${order.id}');
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailUserOrder(
              orderID: order.id,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.white,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: OrderItemProduct(order: order),
        ),
      ),
    );
  }
}
