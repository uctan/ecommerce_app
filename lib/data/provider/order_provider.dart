import 'dart:convert';

import 'package:app_ecomerce/data/model/order.dart';
import 'package:app_ecomerce/data/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderProvider extends ChangeNotifier {
  final List<Order> _order = [];

  List<Order> get order => _order;

  Future<void> getAllOrderDetail(String userId) async {
    var url = Uri.parse(
        '${ApiEndPoints.baseUrl + ApiEndPoints.orderEndPoints.getAllOrder}/$userId');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var eachTeam in jsonData['data']) {
        ShippingAddress shippingAddress = ShippingAddress.fromMap(
          eachTeam['shippingAddress'] as Map<String, dynamic>,
        );

        List<OrderItem> orderItems = List<OrderItem>.from(
          (eachTeam['orderItems'] as List).map(
            (item) => OrderItem.fromMap(item as Map<String, dynamic>),
          ),
        );

        final order = Order(
          shippingAddress: shippingAddress,
          orderItems: orderItems,
          paymentMethod: eachTeam['paymentMethod'],
          itemsPrice: eachTeam['itemsPrice'] as int,
          totalPrice: eachTeam['totalPrice'] as int,
          user: eachTeam['user'].toString(),
          isPaid: eachTeam['isPaid'] ?? false,
          isDelivered: eachTeam['isDelivered'] ?? false,
          id: eachTeam['_id'].toString(),
          shippingPrice: eachTeam['shippingPrice'] as int,
        );
        _order.add(order);
      }
      notifyListeners();
    } else {
      print('loi fetch order : ${response.statusCode}');
    }
  }
}
