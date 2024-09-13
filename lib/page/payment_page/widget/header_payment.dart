import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeaderPayment extends StatelessWidget {
  const HeaderPayment({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        )
      ],
    );
  }
}
