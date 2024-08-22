import 'package:app_ecomerce/common/config/coloors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingGear extends StatelessWidget {
  const SettingGear({
    super.key,
    required this.imgIcon,
  });
  final IconData imgIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 10,
          color: Coloors.borderContainer,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Coloors.borderContainer,
      ),
      child: Center(
        child: Icon(
          // FontAwesomeIcons.gear,
          imgIcon,
          size: 15,
        ),
      ),
    );
  }
}
