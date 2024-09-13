import 'package:app_ecomerce/common/config/constants.dart';
import 'package:app_ecomerce/data/model/order.dart';
import 'package:app_ecomerce/data/model/user_api.dart';
import 'package:app_ecomerce/data/service/order_service.dart';
import 'package:app_ecomerce/data/service/user_service.dart';
import 'package:app_ecomerce/page/order_user_page/widget/item_order.dart';
import 'package:app_ecomerce/page/order_user_page/widget/order_empty.dart';
import 'package:app_ecomerce/page/payment_page/widget/header_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderUserPage extends StatefulWidget {
  const OrderUserPage({super.key});

  @override
  State<OrderUserPage> createState() => _OrderUserPageState();
}

class _OrderUserPageState extends State<OrderUserPage> {
  User _user = User();
  final UserService _userService = UserService();
  final OrderService _orderService = OrderService();
  List<Order> _orders = [];
  bool _isLoading = true;

  Future<void> _fetchCurrentUser() async {
    _userService.setUpdateListerner(() async {
      if (_userService.users.isNotEmpty) {
        _user = _userService.users.first;

        _orderService.setUpdateListener(() {
          setState(() {
            _orders = _orderService.orders;
            print("order count : ${_orders.length}");
            _isLoading = false;
          });
        });
      }
    });

    await _userService.fetchUserCurrent();
    await _orderService.getAllOrderDetail(_user.id.toString());
  }

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else if (_user.id == null || _user.id!.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: OrderEmptyPage(),
        ),
      );
    } else if (_orders.isEmpty) {
      // Hiển thị khi không có đơn hàng
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: Column(
            children: [
              HeaderPayment(
                onPressed: () {},
                text: 'Order History',
              ),
              SizedBox(height: 15),
              Expanded(
                child: OrderEmptyPage(),
              ),
            ],
          ),
        ),
      );
    }

    // Hiển thị danh sách đơn hàng nếu có
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              HeaderPayment(
                onPressed: () {},
                text: 'Order History',
              ),
              SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: _orders.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ItemOrder(
                        order: _orders[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
