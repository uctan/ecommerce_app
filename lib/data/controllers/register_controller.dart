import 'dart:convert';
import 'package:app_ecomerce/common/helper/show_alert_dialog.dart';
import 'package:app_ecomerce/data/utils/api_endpoints.dart';
import 'package:app_ecomerce/page/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail(BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.register,
    );
    Map body = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone': phoneController.text,
      'address': addressController.text,
      'city': cityController.text,
      'avatar': '',
      'isAdmin': false,
      'confirmPassword': confirmpasswordController.text
    };
    http.Response response = await http.post(
      url,
      body: jsonEncode(body),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status'] == 'OK') {
        // Hiển thị thông báo thành công
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Đăng ký thành công'),
              content: Text(
                  'Bạn đã đăng ký thành công. Chuyển sang trang đăng nhập.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    nameController.clear();
                    emailController.clear();
                    passwordController.clear();
                    confirmpasswordController.clear();
                    phoneController.clear();
                    addressController.clear();
                    cityController.clear();

                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        showAlertDialog(
          context: context,
          message: json['message'] ?? 'Lỗi không xác định',
        );
      }
    } else {
      print(
          'RegisterController: Lỗi từ API: ${jsonDecode(response.body)['Message']}');
    }
  }
}
