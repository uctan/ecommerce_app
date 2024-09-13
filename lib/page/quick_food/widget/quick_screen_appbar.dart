import 'package:app_ecomerce/common/app_state_cubit/app_state_cubit.dart';
import 'package:app_ecomerce/page/detail_page/widget/cart_item_badge.dart';
import 'package:app_ecomerce/page/home_page/page/main_page.dart';
import 'package:app_ecomerce/page/shopping_cart/page/shopping_cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import widget CartItemBadge

class QuickScreenAppbar extends StatelessWidget {
  const QuickScreenAppbar({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    int cartItemsNo = context.watch<AppStateCubit>().items.length;
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
            );
          },
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            fixedSize: const Size(45, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          icon: Icon(CupertinoIcons.chevron_back),
        ),
        const Spacer(),
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCartPage(),
                ));
          },
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.3),
            ),
            child: CartItemBadge(
              cartItemsNo: cartItemsNo,
              badgeColor: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
