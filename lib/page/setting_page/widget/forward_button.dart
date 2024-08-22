import 'package:flutter/material.dart';

class ForwardButton extends StatelessWidget {
  const ForwardButton({
    super.key,
    required this.imgIconData,
    required this.onTap,
  });
  final IconData imgIconData;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          imgIconData,
          size: 15,
        ),
      ),
    );
  }
}
