import 'package:app_ecomerce/data/model/cart_item.dart';
import 'package:app_ecomerce/data/model/user_api.dart';
import 'package:app_ecomerce/data/provider/cart_provider.dart';
import 'package:app_ecomerce/data/service/user_service.dart';
import 'package:app_ecomerce/page/shopping_cart/widget/shopping_cart_empty.dart';
import 'package:app_ecomerce/page/shopping_cart/widget/shopping_cart_header.dart';
import 'package:app_ecomerce/page/shopping_cart/widget/shopping_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  User _user = User();
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    _userService.setUpdateListerner(() {
      setState(() {
        if (_userService.users.isNotEmpty) {
          _user = _userService.users.first;
        }
      });
    });
    _userService.fetchUserCurrent();
  }

  @override
  Widget build(BuildContext context) {
    if (_user.id == null || _user.id!.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => CartProvider(_user.id!),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ShoppingCartHeader(),
              Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  final List<CartItem> cartItems = cartProvider.cartItems;

                  if (cartItems.isEmpty) {
                    return ShoppingCartEmpty();
                  }

                  return ShoppingList(cartItems: cartItems);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
