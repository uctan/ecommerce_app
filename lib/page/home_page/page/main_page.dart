import 'package:app_ecomerce/common/config/constants.dart';
import 'package:app_ecomerce/page/home_page/page/home_page.dart';
import 'package:app_ecomerce/page/order_user_page/page/order_user_page.dart';
import 'package:app_ecomerce/page/quick_food/list_product_promotion.dart';
import 'package:app_ecomerce/page/setting_page/page/setting_page.dart';
import 'package:app_ecomerce/page/shopping_cart/page/shopping_cart_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentTab = 0;
  List screens = [
    HomePage(),
    ListProductPromotion(),
    ShoppingCartPage(),
    OrderUserPage(),
    SettingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 0;
              }),
              child: Column(
                children: [
                  Icon(
                    currentTab == 0 ? Iconsax.home : Iconsax.home,
                    color: currentTab == 0 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 0 ? kprimaryColor : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 1;
              }),
              child: Column(
                children: [
                  Icon(
                    currentTab == 1
                        ? Iconsax.percentage_square
                        : Iconsax.percentage_square,
                    color: currentTab == 1 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    'Promotion',
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 1 ? kprimaryColor : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 2;
              }),
              child: Column(
                children: [
                  Icon(
                    currentTab == 2
                        ? FontAwesomeIcons.cartShopping
                        : FontAwesomeIcons.cartShopping,
                    color: currentTab == 2 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    'Cart',
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 2 ? kprimaryColor : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 3;
              }),
              child: Column(
                children: [
                  Icon(
                    currentTab == 3
                        ? FontAwesomeIcons.boxesPacking
                        : FontAwesomeIcons.boxesPacking,
                    color: currentTab == 3 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    'Order',
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 3 ? kprimaryColor : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 4;
              }),
              child: Column(
                children: [
                  Icon(
                    currentTab == 4
                        ? FontAwesomeIcons.gear
                        : FontAwesomeIcons.gear,
                    color: currentTab == 4 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 4 ? kprimaryColor : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: screens[currentTab],
    );
  }
}
