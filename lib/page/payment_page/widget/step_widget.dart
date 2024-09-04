import 'package:app_ecomerce/page/payment_page/widget/timeLine_widget.dart';
import 'package:flutter/material.dart';

class ShippingFeePay extends StatelessWidget {
  const ShippingFeePay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shipping costs',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 265,
          child: Column(
            children: [
              MyTimeLineTile(
                isFirst: true,
                isLast: false,
                isPast: true,
                evenCard: Text(
                  "Nếu đơn hàng của bán dưới 200.000VNĐ thì tiền ship là 20.000VNĐ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              MyTimeLineTile(
                isFirst: false,
                isLast: false,
                isPast: true,
                evenCard: Text(
                  "Nếu đơn hàng của bán từ 200.000 VNĐ đến dưới 500.000 VNĐ thì tiền ship là 10.000VNĐ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              MyTimeLineTile(
                isFirst: false,
                isLast: true,
                isPast: false,
                evenCard: Text(
                  "Nếu đơn hàng của bán trên 500.000VNĐ thì được miễn phí vận chuyển",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
