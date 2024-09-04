import 'package:app_ecomerce/page/payment_page/widget/header_payment.dart';
import 'package:flutter/material.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  int? selectedValue;
  String getSelectedDeliveryText() {
    if (selectedValue == 1) {
      return 'Giao hàng tiết kiệt';
    } else if (selectedValue == 2) {
      return 'Giao hàng GOJEK';
    }
    return 'Chưa chọn phương thức giao hàng';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 15),
              HeaderPayment(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'Shipping method',
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/giaohangtietkiem.png',
                        width: 60,
                        height: 60,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Giao hàng tiết kiệm',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Radio<int>(
                        value: 1,
                        groupValue: selectedValue,
                        onChanged: (int? value) {
                          setState(() {
                            selectedValue = value;
                          });
                          Navigator.pop(context, selectedValue);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/gojek.png',
                        width: 60,
                        height: 60,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Giao hàng GOJEK',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Radio<int>(
                        value: 2,
                        groupValue: selectedValue,
                        onChanged: (int? value) {
                          setState(() {
                            selectedValue = value;
                          });
                          Navigator.pop(context, selectedValue);
                        },
                      ),
                    ],
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
