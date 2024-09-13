import 'package:app_ecomerce/data/provider/order_provider.dart';
import 'package:app_ecomerce/page/payment_page/page/delivery_method.dart';
import 'package:app_ecomerce/page/payment_page/page/information_order.dart';
import 'package:app_ecomerce/page/payment_page/page/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/user_api.dart';
import '../../../data/provider/cart_provider.dart';
import '../../../data/service/user_service.dart';
import '../widget/header_payment.dart';

class PayMentPage extends StatefulWidget {
  const PayMentPage({super.key, required this.shippingFee});
  final double shippingFee;

  @override
  State<PayMentPage> createState() => _PayMentPageState();
}

class _PayMentPageState extends State<PayMentPage> {
  int? selectedDeliveryMethod;
  int? selectedPaymentMethod;
  User _user = User();
  final UserService _userService = UserService();
  String? accessToken;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _fetchUsercurrent();
    _loadAccessToken();
  }

  Future<void> _loadAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('access_token');
    });
  }

  void _fetchUsercurrent() async {
    _userService.setUpdateListerner(() {
      if (mounted) {
        setState(() {
          if (_userService.users.isNotEmpty) {
            _user = _userService.users.first;
          }
        });
      }
    });
    _userService.fetchUserCurrent();
  }

  Future<void> _handleOrder() async {
    setState(() {
      isLoading = true;
    });

    final cartProvider = context.read<CartProvider>();
    final orderProvider = context.read<OrderProvider>();
    final itemsPrice = cartProvider.totalPrice;
    final totalPrice = itemsPrice + widget.shippingFee;

    try {
      await orderProvider.createOrder(
        paymentMethod: 'later_money',
        itemsPrice: itemsPrice,
        shippingPrice: widget.shippingFee,
        totalPrice: totalPrice,
        fullName: _user.name ?? '',
        address: _user.address ?? '',
        city: _user.city ?? '',
        phone: _user.phone.toString(),
        user: _user.id ?? '',
        isPaid: selectedPaymentMethod == 1,
        paidAt: selectedPaymentMethod == 1
            ? DateTime.now().toIso8601String()
            : null,
        email: _user.email ?? '',
        accessToken: accessToken ?? '',
        context: context,
      );
    } catch (e) {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final totalPriceFormatted =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ').format(
      cartProvider.totalPrice,
    );
    final shippingPriceFormatted =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ')
            .format(widget.shippingFee);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 35,
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: Column(
                children: [
                  SizedBox(height: 0),
                  HeaderPayment(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    text: 'Payment',
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InformationOrderPage(
                              user: _user,
                            ),
                          ));
                    },
                    child: Container(
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        _user.name ?? 'Loading...',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 9),
                                      Text(
                                        '(+84) ${_user.phone.toString()}',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text('${_user.address}\n${_user.city}')
                                ],
                              ),
                              Icon(
                                Icons.arrow_right_rounded,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeliveryPage(),
                        ),
                      ).then((value) {
                        setState(() {
                          selectedDeliveryMethod = value;
                        });
                      });
                    },
                    child: Container(
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          )),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Shipping method (Click to select) ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 52.5),
                                      Icon(
                                        Icons.arrow_right_rounded,
                                        size: 30,
                                      ),
                                      SizedBox(width: 9),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    selectedDeliveryMethod == 1
                                        ? 'Giao hàng tiết kiệm'
                                        : selectedDeliveryMethod == 2
                                            ? 'Gio hàng GOJEK'
                                            : 'Chưa chọn phương thức giao hàng',
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentMethodPage(),
                        ),
                      ).then((value) {
                        setState(() {
                          selectedPaymentMethod = value;
                        });
                      });
                    },
                    child: Container(
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          )),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Payment Methods (See all)',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 100.5),
                                      Icon(
                                        Icons.arrow_right_rounded,
                                        size: 30,
                                      ),
                                      SizedBox(width: 9),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    selectedPaymentMethod == 1
                                        ? 'Thanh toán bằng ngân hàng Paypal'
                                        : selectedPaymentMethod == 2
                                            ? 'Thanh toán khi nhận hàng'
                                            : 'Chưa chọn phương thức thanh toán',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          )),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Order details',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Tổng số lượng đặt hàng',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(width: 160),
                                      Text(
                                        Provider.of<CartProvider>(context)
                                            .cartCount
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Phí vận chuyển',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(width: 160),
                                      Text(
                                        shippingPriceFormatted,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        'Tổng tiền',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 140),
                                      Text(
                                        totalPriceFormatted,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 119),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Total amount:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              totalPriceFormatted,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () async {
                                if (selectedDeliveryMethod.isNull &&
                                    selectedPaymentMethod.isNull) {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.warning,
                                    text:
                                        'You have not selected a payment or shipping method.',
                                  );
                                } else {
                                  await _handleOrder();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                minimumSize: Size(110, 20),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text(
                                'Confirm',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            if (isLoading) // Hiển thị CircularProgressIndicator khi đang đặt hàng
                              Container(
                                color: Colors.black.withOpacity(0.2),
                                child: Center(),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading) // Hiển thị CircularProgressIndicator khi đang đặt hàng
            Container(
              color: Colors.black.withOpacity(0.2),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
