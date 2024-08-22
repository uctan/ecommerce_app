import 'package:app_ecomerce/common/config/constants.dart';
import 'package:app_ecomerce/widget/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            color: ksearchColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search any recipes",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            showCustomModalBottomSheet(context: context);
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: ksearchColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              FontAwesomeIcons.sliders,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
