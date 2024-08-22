import 'package:app_ecomerce/common/app_state_cubit/app_state_cubit.dart';
import 'package:app_ecomerce/data/model/cart_item.dart';
import 'package:app_ecomerce/data/model/product_api.dart';
import 'package:app_ecomerce/data/provider/cart_provider.dart';
import 'package:app_ecomerce/page/shopping_cart/widget/shopping_cart_empty.dart';
import 'package:app_ecomerce/page/shopping_cart/widget/shopping_cart_header.dart';
import 'package:app_ecomerce/page/shopping_cart/widget/shopping_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> items = context.read<AppStateCubit>().items;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShoppingCartHeader(),
            // items.isNotEmpty
            //     ? ShoppingList(
            //         cartItems: items
            //             .map((item) => CartItem(product: item, quantity: 1))
            //             .toList(),
            //       )
            //     : ShoppingCartEmpty(),
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                final List<CartItem> cartItems = cartProvider.cartItems;

                if (cartItems.isEmpty) {
                  return ShoppingCartEmpty();
                }

                return ShoppingList(cartItems: cartItems);
              },
            )
          ],
        ),
      ),
    );
  }
}
