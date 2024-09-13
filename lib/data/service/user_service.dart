import 'dart:convert';
import 'dart:ui';
import 'package:app_ecomerce/data/model/user_api.dart';
import 'package:app_ecomerce/data/utils/api_endpoints.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserService {
  VoidCallback? onPresentUser;
  List<User> users = [];

  void setUpdateListerner(VoidCallback onUpdate) {
    onPresentUser = onUpdate;
  }

  Future<String?> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString("access_token");

    if (accessToken != null) {
      try {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        print('Decoded Token: $decodedToken');

        String? userId = decodedToken['id'];
        return userId;
      } catch (e) {
        print("Failed to decode token: $e");
      }
    }
    return null;
  }

  Future<void> fetchUserCurrent() async {
    String? userId = await getUserId();
    if (userId != null) {
      var url = Uri.parse(
        '${ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getDetailUser}/$userId',
      );

      try {
        var response = await http.get(url);

        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body)['data'];
          if (jsonData != null) {
            final user = User(
              name: jsonData['name'],
              id: jsonData['_id'],
              phone: jsonData['phone'],
              avatar: jsonData['avatar'],
              address: jsonData['address'],
              email: jsonData['email'],
              city: jsonData['city'],
            );
            users = [user];
            onPresentUser?.call();
            print('$jsonData');
          } else {
            print('No data found in response.');
          }
        } else {
          print('Error: Status code ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching user details: $e');
      }
    } else {
      print('User ID is null. Cannot fetch user details.');
    }
  }

  Future<void> logoutUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString("access_token");
    var url = Uri.parse(
        '${ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.logoutUser}');
    try {
      var reponse = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (reponse.statusCode == 200) {
        final responseData = jsonDecode(reponse.body);
        print('$responseData');
      }
    } catch (e) {
      print('$e');
    }
  }
}
