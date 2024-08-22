import 'dart:convert';

import 'package:app_ecomerce/data/utils/api_endpoints.dart';
import 'package:app_ecomerce/page/home_page/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future loginnUser(BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.login,
    );
    Map body = {
      'email': emailController.text,
      'password': passwordController.text,
    };
    http.Response response = await http.post(
      url,
      body: jsonEncode(body),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json);
      if (json['status'] == 'OK') {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString("access_token", json['access_token']);
        await pref.setString("refresh_token", json['refresh_token']);
        emailController.clear();
        passwordController.clear();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
        );
      } else {
        print(json['status']);
      }
    }
  }
}
