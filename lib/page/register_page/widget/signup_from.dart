import 'package:app_ecomerce/data/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final RegisterController registerController = Get.put(RegisterController());

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('Name', false, registerController.nameController),
        buildInputForm('Phone', false, registerController.phoneController),
        buildInputForm('Email', false, registerController.emailController),
        buildInputForm('Password', true, registerController.passwordController),
        buildInputForm('ConfirmPassword', true,
            registerController.confirmpasswordController),
        buildInputForm('Address', false, registerController.addressController),
        buildInputForm('City', false, registerController.cityController),
        SizedBox(height: 20),
      ],
    );
  }

  Padding buildInputForm(
      String hint, bool pass, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: pass ? _isObscure : false,
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          )
                        : Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          ),
                  )
                : null),
      ),
    );
  }
}
