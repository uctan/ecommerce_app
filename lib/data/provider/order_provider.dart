import 'dart:convert';
import 'package:app_ecomerce/data/provider/cart_provider.dart';
import 'package:app_ecomerce/data/utils/api_endpoints.dart';
import 'package:app_ecomerce/page/payment_page/page/payment_success.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderProvider extends ChangeNotifier {
  final CartProvider cartProvider;
  OrderProvider({required this.cartProvider});

  Future<void> createOrder({
    required String paymentMethod,
    required double itemsPrice,
    required double shippingPrice,
    required double totalPrice,
    required String fullName,
    required String address,
    required String city,
    required String phone,
    required String user,
    required bool isPaid,
    String? paidAt,
    required String email,
    required String accessToken,
    required BuildContext context,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final List<Map<String, dynamic>> orderItems = cartProvider.cartItems
        .map((item) => {
              'product': item.product.id,
              'name': item.product.name,
              'amount': item.quantity,
              'image': item.product.image,
              'price': item.product.price,
              'discount': item.product.discount,
            })
        .toList();

    Map<String, dynamic> orderData = {
      'paymentMethod': paymentMethod,
      'itemsPrice': itemsPrice,
      'shippingPrice': shippingPrice,
      'totalPrice': totalPrice,
      'fullName': fullName,
      'address': address,
      'city': city,
      'phone': phone,
      'orderItems': orderItems,
      'user': user,
      'isPaid': isPaid,
      'paidAt': paidAt,
      'email': email,
    };

    print('Dữ liệu đơn hàng gửi đi: ${jsonEncode(orderData)}');

    final url =
        ApiEndPoints.baseUrl + ApiEndPoints.orderEndPoints.postCreateOrder;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(orderData),
      );

      print('Trạng thái phản hồi: ${response.statusCode}');
      print('Nội dung phản hồi: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == 'OK') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentSuccess(),
            ),
          );
        } else {
          throw Exception(jsonResponse['message']);
        }
        print('Phản hồi từ API: $jsonResponse');
        // Xử lý đơn hàng thành công ở đây (ví dụ: xóa giỏ hàng, hiển thị thông báo thành công)
      } else {
        throw Exception('Lỗi server: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi khi tạo đơn hàng: $e');
      throw Exception('Không thể tạo đơn hàng: $e');
    }
  }
}
