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
            // itemsPrice: eachTeam['itemsPrice'] as double,
            // totalPrice: eachTeam['totalPrice'] as double,
            itemsPrice: eachTeam['itemsPrice'],
            totalPrice: eachTeam['totalPrice'],
            user: eachTeam['user'].toString(),
            isPaid: eachTeam['isPaid'] ?? false,
            isDelivered: eachTeam['isDelivered'] ?? false,
            id: eachTeam['_id'].toString(),
            shippingPrice: eachTeam['shippingPrice'],
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

  Future<void> getDetailOrderUser(String orderID) async {
    var url = Uri.parse(
        '${ApiEndPoints.baseUrl + ApiEndPoints.orderEndPoints.getDetailOrder}/$orderID');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('Response body: ${response.body}');

        var data = jsonData['data'];

        // Kiểm tra nếu 'data' là Map
        if (data is Map<String, dynamic>) {
          ShippingAddress shippingAddress = ShippingAddress.fromMap(
            data['shippingAddress'] as Map<String, dynamic>,
          );

          List<OrderItem> orderItems = List<OrderItem>.from(
            (data['orderItems'] as List).map(
              (item) => OrderItem.fromMap(item as Map<String, dynamic>),
            ),
          );

          final order = Order(
            shippingAddress: shippingAddress,
            orderItems: orderItems,
            paymentMethod: data['paymentMethod'],
            itemsPrice: data['itemsPrice'],
            totalPrice: data['totalPrice'],
            user: data['user'].toString(),
            isPaid: data['isPaid'] ?? false,
            isDelivered: data['isDelivered'] ?? false,
            id: data['_id'].toString(),
            shippingPrice: data['shippingPrice'],
          );

          // Thêm đối tượng Order vào danh sách orders
          orders.add(order);
          onPresentOrder?.call();
        } else {
          print('Unexpected data format.');
        }
      } else {
        print('Failed to fetch orders. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }
}
