import 'package:app_ecomerce/common/config/constants.dart';
import 'package:app_ecomerce/page/payment_page/widget/header_payment.dart';
import 'package:app_ecomerce/page/quick_food/list_food_screen.dart';
import 'package:flutter/material.dart';

class OrderEmptyPage extends StatelessWidget {
  const OrderEmptyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Image.asset(
            'assets/images/orderempty.png',
            width: 350,
            height: 350,
          ),
          Text(
            'Your shopping order is emptys',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Fortunately,there's an easy solution",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListFoodPage(),
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
                  'Go to Shopping',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
