import 'package:app_ecomerce/data/controllers/login_controller.dart';
import 'package:app_ecomerce/page/login_page/widget/login_form.dart';
import 'package:app_ecomerce/page/login_page/widget/login_option.dart';
import 'package:app_ecomerce/page/login_page/widget/primary_button.dart';
import 'package:app_ecomerce/page/register_page/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'Welcome Back',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  'New to this APP?',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            LogInForm(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            PrimaryButton(
              buttonText: 'Log In',
              onPressed: () async {
                await loginController.loginnUser(context);
              },
            ),
            SizedBox(height: 20),
            Text(
              'Or log in with:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            LoginOption(),
          ],
        ),
      ),
    );
  }
}
