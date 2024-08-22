// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'package:app_ecomerce/data/model/cart_item.dart';
import 'package:app_ecomerce/page/shopping_cart/widget/shopping_list_item_widget.dart';
import 'package:app_ecomerce/page/shopping_cart/widget/shopping_list_price.dart';

class ShoppingList extends StatelessWidget {
  final List<CartItem> cartItems;

  ShoppingList({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              // children: cartItems
              //     .map((e) => ShopListItemWidget(
              //           cartItem: e,
              //           quantity: e.quantity,
              //         ))
              //     .toList(),
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return ShopListItemWidget(
                  cartItem: cartItem,
                  index: index,
                );
              },
            ),
          ),
          ShoppingListPrice(),
        ],
      ),
    );
  }
}
