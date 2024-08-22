import 'package:app_ecomerce/page/home_page/page/main_page.dart';
import 'package:app_ecomerce/page/setting_page/infor_page/page/edit_infor_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String homepage = 'homepage';
  static const String editinfor = 'editinfor';
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homepage:
        return MaterialPageRoute(
          builder: (context) => const MainPage(),
        );
      case editinfor:
        return MaterialPageRoute(
          builder: (context) => const EditInforPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No Page Route Provided'),
            ),
          ),
        );
    }
  }
}
