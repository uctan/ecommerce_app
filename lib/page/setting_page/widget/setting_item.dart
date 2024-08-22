import 'package:app_ecomerce/page/setting_page/widget/forward_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    this.bgColor,
    this.iconColor,
    required this.icon,
    required this.onTap,
    this.value,
    required this.iconArrow,
  });
  final String title;
  final Color? bgColor;
  final Color? iconColor;
  final IconData icon;
  final Function() onTap;
  final String? value;
  final IconData iconArrow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          value != null
              ? Text(
                  value!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              : const SizedBox(),
          SizedBox(width: 20),
          ForwardButton(
            // imgIconData: FontAwesomeIcons.arrowDown,
            imgIconData: iconArrow,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
