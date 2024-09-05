import 'dart:convert';
import 'package:app_ecomerce/data/model/cart_item.dart';
import 'package:app_ecomerce/data/model/order.dart';
import 'package:app_ecomerce/data/provider/cart_provider.dart';
import 'package:app_ecomerce/data/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderProvider extends ChangeNotifier {
  final CartProvider cartProvider;
  OrderProvider({required this.cartProvider});

  Future<void> createOrder(
    String paymentMethod,
    bool isPaid,
    bool isDelivered,
    double shippingPrice,
    double totalPrice,
    String fullName,
    String address,
    String city,
    int phone,
    String user,
  ) async {
    var headers = {'Content-Type': 'application/json'};
    final List<CartItem> _cartItems = cartProvider.cartItems;

    // Tạo đối tượng ShippingAddress
    final shippingAddress = {
      'fullName': fullName,
      'address': address,
      'city': city,
      'phone': phone,
    };

    // Tạo đối tượng OrderItem từ các mục trong giỏ hàng
    final orderItems = _cartItems
        .map(
          (item) => {
            'name': item.product.name ?? '',
            'amount': item.quantity ?? 0,
            'price': item.product.price?.toString() ?? '0.0',
            'image': item.product.image ?? '',
            'discount': item.product.discount ?? 0.0,
            'product': item.product.id,
          },
        )
        .toList();
    print('orderItems nha : $orderItems');

    // Chuẩn bị dữ liệu cho order theo định dạng API yêu cầu
    final orderData = {
      'paymentMethod': paymentMethod,
      'itemsPrice': cartProvider.totalPrice ?? 0.0,
      'shippingPrice': shippingPrice,
      'totalPrice': totalPrice,
      'shippingAddress': shippingAddress, // Sử dụng shippingAddress
      'orderItems': orderItems, // Chuyển đổi trực tiếp
      'user': user,
      'isPaid': isPaid,
      'isDelivered': isDelivered,
    };

    print('Order Data: ${jsonEncode(orderData)}'); // Log dữ liệu gửi đi

    final url =
        ApiEndPoints.baseUrl + ApiEndPoints.orderEndPoints.postCreateOrder;

    final response = await http.post(
      Uri.parse(url),
      // headers: headers,
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print('Response from API: $jsonResponse');
    } else {
      final errorResponse = jsonDecode(response.body);
      print('Failed to create order: ${errorResponse['message']}');
      throw Exception('Failed to create order: ${errorResponse['message']}');
    }
  }
}
