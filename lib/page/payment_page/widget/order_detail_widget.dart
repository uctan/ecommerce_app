import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPayMentWidget extends StatefulWidget {
  const DetailPayMentWidget({
    super.key,
  });

  @override
  State<DetailPayMentWidget> createState() => _DetailPayMentWidgetState();
}

class _DetailPayMentWidgetState extends State<DetailPayMentWidget> {
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order date:',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            Text(
              formattedDate,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
