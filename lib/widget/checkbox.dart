import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({super.key, required this.text});
  final String text;

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isSelected = !_isSelected;
            });
          },
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.blue,
              ),
            ),
            child: _isSelected
                ? Icon(
                    Icons.check,
                    size: 17,
                    color: Colors.blue,
                  )
                : null,
          ),
        ),
        SizedBox(width: 12),
        Text(widget.text)
      ],
    );
  }
}
