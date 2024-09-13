import 'package:app_ecomerce/common/config/constants.dart';
import 'package:app_ecomerce/data/model/cart_item.dart';
import 'package:app_ecomerce/data/provider/cart_provider.dart';
import 'package:app_ecomerce/page/payment_page/page/information_order.dart';
import 'package:app_ecomerce/page/payment_page/page/payment_page.dart';
import 'package:app_ecomerce/page/payment_page/widget/header_payment.dart';
import 'package:app_ecomerce/page/payment_page/widget/order_detail_widget.dart';
import 'package:app_ecomerce/page/payment_page/widget/payment_product_widget.dart';
import 'package:app_ecomerce/page/payment_page/widget/step_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage({super.key, required this.cartItems});
  final List<CartItem> cartItems;

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  @override
  Widget build(BuildContext context) {
    double shippingFee = 0.0;
    if (Provider.of<CartProvider>(context).totalPrice > 500000.0) {
      shippingFee = 0;
    } else if (Provider.of<CartProvider>(context).totalPrice < 500000.0 &&
        Provider.of<CartProvider>(context).totalPrice > 200000.0) {
      shippingFee = 10000.0;
    } else {
      shippingFee = 20000.0;
    }

    double totalFee =
        shippingFee + (Provider.of<CartProvider>(context).totalPrice);
    final totalPriceFormatted =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ').format(totalFee);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 35,
            left: 10,
            right: 10,
            bottom: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderPayment(
                onPressed: () => Navigator.of(context).pop(),
                text: 'Track Order',
              ),
              SizedBox(height: 10),
              PaymentProductWidget(
                cartItems: widget.cartItems,
              ),
              SizedBox(height: 15),
              const Divider(),
              SizedBox(height: 10),
              DetailPayMentWidget(),
              SizedBox(height: 15),
              const Divider(),
              SizedBox(height: 10),
              ShippingFeePay(),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Unit price',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          Provider.of<CartProvider>(context)
                              .totalPrice
                              .toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shipping fee',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          shippingFee.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          totalPriceFormatted,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PayMentPage(
                              shippingFee: shippingFee,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          color: kprimaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            'CHECKOUT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
