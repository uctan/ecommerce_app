import 'package:app_ecomerce/data/model/order.dart';
import 'package:app_ecomerce/data/service/order_service.dart';
import 'package:app_ecomerce/page/payment_page/widget/header_payment.dart';
import 'package:flutter/material.dart';

class DetailUserOrder extends StatefulWidget {
  const DetailUserOrder({super.key, this.orderID});
  final orderID;

  @override
  State<DetailUserOrder> createState() => _DetailUserOrderState();
}

class _DetailUserOrderState extends State<DetailUserOrder> {
  final OrderService _orderService = OrderService();
  Order orders = Order();
  List<Order> _orders = [];

  Future<void> _fetchOrderDetailUser(String orderID) async {
    print(
        'Fetching order detail for orderID: $orderID'); // Log kiểm tra giá trị orderID

    _orderService.setUpdateListener(() {
      setState(() {
        _orders = _orderService.orders;
        print("order count nha nha: ${_orders.length}");
        print(
            'order nhan ${widget.orderID}'); // Log kiểm tra giá trị widget.orderID

        // Đặt log để kiểm tra giá trị orders.shippingAddress.fullName
        if (_orders.isNotEmpty) {
          orders = _orders.first; // Giả sử chỉ có một đơn hàng được trả về
          print(
              'Full name of shipping address: ${orders.shippingAddress?.fullName ?? 'Loading'}');
        }
      });
    });

    await _orderService.getDetailOrderUser(orderID);
  }

  @override
  void initState() {
    super.initState();
    print('InitState called with orderID: ${widget.orderID}');
    _fetchOrderDetailUser(widget.orderID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 35,
            left: 10,
            right: 10,
            bottom: 10,
          ),
          child: Column(
            children: [
              HeaderPayment(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'OrderDetails',
              ),
              SizedBox(height: 10),
              Container(
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
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Địa chỉ người nhận:',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              orders.shippingAddress?.fullName ?? 'Loading',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 9),
                            Text(
                              '(+84) ${orders.shippingAddress?.phone}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text('${orders.shippingAddress?.address}'),
                        Text('${orders.shippingAddress?.city}')
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
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
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hình thức giao hàng:',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          orders.isDelivered == false
                              ? 'Giao hàng tiết kiết kiệm'
                              : orders.isDelivered == true
                                  ? 'Giao hàng GOJEK'
                                  : 'Bị lỗi',
                        ),
                        Text('${orders.shippingPrice} VNĐ')
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
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
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hình thức thanh toán:',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          orders.paymentMethod.toString(),
                        ),
                        Text(
                          orders.isPaid == false
                              ? 'Thanh toán khi nhận hàng'
                              : orders.isDelivered == true
                                  ? 'Thanh toán bằng thẻ'
                                  : 'Bị lỗi',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
