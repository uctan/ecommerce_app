import 'package:app_ecomerce/common/app_state_cubit/app_state_cubit.dart';
import 'package:app_ecomerce/data/provider/cart_provider.dart';
import 'package:app_ecomerce/common/config/constants.dart';
import 'package:app_ecomerce/common/routes/routes.dart';
import 'package:app_ecomerce/page/home_page/page/main_page.dart';
import 'package:app_ecomerce/page/introduction_page/page/my_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('access_token');
  runApp(
    MyApp(
      accessToken: accessToken ?? '',
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    this.accessToken = '',
  });
  final String accessToken;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
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
