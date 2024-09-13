import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeLineTile extends StatelessWidget {
  const MyTimeLineTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.evenCard,
  });
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final Widget evenCard;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(color: Colors.blue),
        indicatorStyle: IndicatorStyle(
          width: 35,
          color: Colors.blue,
          iconStyle: IconStyle(
            iconData: Icons.done,
            color: Colors.white,
          ),
        ),
        endChild: Container(
          padding: EdgeInsets.all(
              8), // Thêm padding để đảm bảo nội dung không bị cắt
          child: evenCard,
        ),
      ),
    );
  }
}
