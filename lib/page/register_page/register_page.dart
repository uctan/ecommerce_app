import 'package:app_ecomerce/data/controllers/register_controller.dart';
import 'package:app_ecomerce/page/login_page/login_page.dart';
import 'package:app_ecomerce/page/login_page/widget/login_option.dart';
import 'package:app_ecomerce/page/login_page/widget/primary_button.dart';
import 'package:app_ecomerce/page/register_page/widget/signup_from.dart';
import 'package:app_ecomerce/widget/checkbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController registerController = Get.put(RegisterController());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        'Already a member?',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            decorationThickness: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: SignUpForm(),
                ),
                SizedBox(height: 0),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: CheckBox(
                    text: 'Agree to term and conditions.',
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: PrimaryButton(
                    buttonText: 'Sign Up',
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await registerController.registerWithEmail(context);
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Or log in with:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                LoginOption(),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
