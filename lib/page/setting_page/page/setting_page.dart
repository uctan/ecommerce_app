import 'package:app_ecomerce/common/config/coloors.dart';
import 'package:app_ecomerce/common/config/constants.dart';
import 'package:app_ecomerce/data/model/user_api.dart';
import 'package:app_ecomerce/data/service/user_service.dart';
import 'package:app_ecomerce/page/login_page/login_page.dart';
import 'package:app_ecomerce/page/setting_page/infor_page/page/edit_infor_page.dart';
import 'package:app_ecomerce/page/setting_page/widget/forward_button.dart';
import 'package:app_ecomerce/page/setting_page/widget/setting_gear.dart';
import 'package:app_ecomerce/page/setting_page/widget/setting_item.dart';
import 'package:app_ecomerce/page/setting_page/widget/setting_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isDarkMode = false;
  User _user = User();
  final UserService _userService = UserService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userService.setUpdateListerner(() {
      setState(() {
        if (_userService.users.isNotEmpty) {
          _user = _userService.users.first;
        }
      });
    });
    _userService.fetchUserCurrent();
  }

  void _logOutUser() async {
    await _userService.logoutUser();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("access_token");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SettingGear(
                        imgIcon: FontAwesomeIcons.gear,
                      ),
                      SizedBox(width: 10),
                      SettingGear(
                        imgIcon: FontAwesomeIcons.magnifyingGlass,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                "Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Coloors.borderContainer,
                      ),
                      child: Icon(
                        FontAwesomeIcons.user,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 10), // Thêm SizedBox để tạo khoảng cách nhỏ
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _user.name ?? 'Loading...',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          _user.email ?? 'Loading...',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    ForwardButton(
                      imgIconData: FontAwesomeIcons.arrowRightLong,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditInforPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              SettingItem(
                title: 'Language',
                icon: FontAwesomeIcons.earthAfrica,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {},
                iconArrow: FontAwesomeIcons.arrowDownLong,
                value: 'English',
              ),
              SizedBox(height: 20),
              SettingItem(
                title: 'Notifications',
                icon: FontAwesomeIcons.bell,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {},
                iconArrow: FontAwesomeIcons.arrowRightLong,
              ),
              SizedBox(height: 20),
              SettingSwitch(
                title: 'DarkMode',
                icon: FontAwesomeIcons.moon,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: isDarkMode,
                onTap: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              SizedBox(height: 20),
              SettingItem(
                title: 'Help',
                icon: FontAwesomeIcons.handshakeAngle,
                bgColor: Colors.yellow.shade100,
                iconColor: Colors.yellow,
                onTap: () {},
                iconArrow: FontAwesomeIcons.arrowRightLong,
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ksearchColor,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          text: 'Do you want to logout',
                          confirmBtnText: 'Yes',
                          cancelBtnText: 'No',
                          confirmBtnColor: Colors.blue,
                          onConfirmBtnTap: _logOutUser,
                          onCancelBtnTap: () {
                            Navigator.of(context).pop();
                          });
                    },
                    child: Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
