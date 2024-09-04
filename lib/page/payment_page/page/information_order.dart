import 'package:app_ecomerce/page/payment_page/widget/header_payment.dart';
import 'package:app_ecomerce/page/payment_page/widget/text_field_information_payment.dart';
import 'package:flutter/material.dart';

class InformationOrderPage extends StatefulWidget {
  const InformationOrderPage({super.key});

  @override
  State<InformationOrderPage> createState() => _InformationOrderPageState();
}

class _InformationOrderPageState extends State<InformationOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
                text: 'Information Order',
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Information and shipping address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFieldInfor(
                      labelText: 'FullName:',
                      text: 'Nguyễn Trần Duy Tân',
                    ),
                    TextFieldInfor(
                      labelText: 'Address:',
                      text: '227/69 Nguyễn Tư Giản p12 quận Gò Vấp',
                    ),
                    TextFieldInfor(
                      labelText: 'City:',
                      text: 'Hồ Chí Minh',
                    ),
                    TextFieldInfor(
                      labelText: 'Phone:',
                      text: '0399441272',
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
