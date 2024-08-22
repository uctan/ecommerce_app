import 'package:app_ecomerce/data/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:app_ecomerce/common/app_state_cubit/app_state_cubit.dart';
import 'package:badges/badges.dart' as badges;

class CartItemBadge extends StatelessWidget {
  final Color badgeColor;
  const CartItemBadge(
      {Key? key, required int cartItemsNo, required this.badgeColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int cartItemsNo = context.read<CartProvider>().cartItems.length;

    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Iconsax.shopping_cart,
          size: 25,
          color: badgeColor,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: badges.Badge(
            badgeContent: Text(
              cartItemsNo.toString(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            badgeAnimation: badges.BadgeAnimation.scale(),
            position: badges.BadgePosition.custom(start: 10),
          ),
        ),
      ],
    );
  }
}
