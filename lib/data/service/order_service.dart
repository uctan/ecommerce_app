import 'dart:convert';
import 'dart:ui';

import 'package:app_ecomerce/data/model/order.dart';
import 'package:app_ecomerce/data/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class OrderService {
  VoidCallback? onPresentOrder;
  List<Order> orders = [];
  late Order order;

  void setUpdateListener(VoidCallback onUpdate) {
    onPresentOrder = onUpdate;
  }

  Future<void> getAllOrderDetail(String userId) async {
    var url = Uri.parse(
        '${ApiEndPoints.baseUrl + ApiEndPoints.orderEndPoints.getAllOrder}/$userId');

    print('Request URL: $url');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('Response body: ${response.body}');
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
          orders.add(order);
        }
        onPresentOrder?.call();
      } else {
        print('Failed to fetch orders. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }
}
