import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        Image.asset(
          'assets/images/i3.png',
          width: 400,
          height: 300,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            'We Need To Work Hard',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'We Need To Work Hard,We Need To Work Hard,We Need To Work Hard',
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
