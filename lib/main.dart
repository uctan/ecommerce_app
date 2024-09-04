import 'package:app_ecomerce/common/app_state_cubit/app_state_cubit.dart';
import 'package:app_ecomerce/data/provider/cart_provider.dart';
import 'package:app_ecomerce/common/config/constants.dart';
import 'package:app_ecomerce/common/routes/routes.dart';
import 'package:app_ecomerce/data/provider/order_provider.dart';
import 'package:app_ecomerce/data/service/user_service.dart';
import 'package:app_ecomerce/page/home_page/page/main_page.dart';
import 'package:app_ecomerce/page/introduction_page/page/my_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('access_token');
  UserService userService = UserService();
  String? userId = await userService.getUserId();

  runApp(
    MyApp(
      accessToken: accessToken ?? '',
      userId: userId ?? '',
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.accessToken,
    required this.userId,
  });

  final String accessToken;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(userId),
        ),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        BlocProvider(
          create: (context) => AppStateCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Biofit",
          colorScheme: ColorScheme.fromSeed(seedColor: kprimaryColor),
          scaffoldBackgroundColor: kbackgroundColor,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        home: accessToken.isNotEmpty ? MainPage() : MyHomeScreen(),
      ),
    );
  }
}
