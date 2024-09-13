import 'dart:convert';
import 'dart:typed_data';

import 'package:app_ecomerce/data/model/user_api.dart';
import 'package:app_ecomerce/data/service/user_service.dart';
import 'package:app_ecomerce/page/setting_page/infor_page/widget/textfield_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditInforPage extends StatefulWidget {
  const EditInforPage({super.key});

  @override
  State<EditInforPage> createState() => _EditInforPageState();
}

class _EditInforPageState extends State<EditInforPage> {
  User _user = User();
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _fetchUsercurrent();
  }

  @override
  void dispose() {
    _userService.onPresentUser = null;
    super.dispose();
  }

  void _fetchUsercurrent() async {
    _userService.setUpdateListerner(() {
      if (mounted) {
        // Kiểm tra widget còn mounted không
        setState(() {
          if (_userService.users.isNotEmpty) {
            _user = _userService.users.first;
          }
        });
      }
    });
    _userService.fetchUserCurrent();
  }

  @override
  Widget build(BuildContext context) {
    String base64String = _user.avatar ?? '';
    Uint8List? decodedBytes;
    if (base64String.isNotEmpty) {
      try {
        decodedBytes = base64Decode(base64String.split(',').last);
      } catch (e) {
        decodedBytes = null;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(FontAwesomeIcons.chevronLeft),
        ),
        leadingWidth: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: const Size(45, 30),
                elevation: 3,
              ),
              icon: const Icon(
                FontAwesomeIcons.gear,
                color: Colors.white,
                size: 15,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Account',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      'Photo',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        if (_user.avatar != null &&
                            _user.avatar!.isNotEmpty &&
                            decodedBytes != null)
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: Image.memory(
                              decodedBytes!,
                              fit: BoxFit.cover,
                            ),
                          )
                        else
                          Image.asset(
                            'assets/images/avatar.png',
                            width: 100,
                            height: 100,
                          ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.lightBlueAccent,
                          ),
                          child: const Text('Upload Image'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              TextFieldItem(
                label: 'FullName',
                labelhint: _user.name ?? 'Loading...',
              ),
              const SizedBox(height: 20),
              TextFieldItem(
                label: 'Phone',
                labelhint: _user.phone.toString() ?? 'Loading...',
              ),
              const SizedBox(height: 20),
              TextFieldItem(
                label: 'Address',
                labelhint: _user.address ?? 'Loading...',
              ),
              const SizedBox(height: 20),
              TextFieldItem(
                label: 'Email',
                labelhint: _user.email ?? 'Loading...',
              ),
              const SizedBox(height: 20),
              TextFieldItem(
                label: 'City',
                labelhint: _user.city ?? 'Loading...',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      backgroundColor: Colors.lightBlueAccent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
