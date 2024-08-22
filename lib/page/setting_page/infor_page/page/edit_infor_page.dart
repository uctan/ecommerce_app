import 'package:app_ecomerce/page/setting_page/infor_page/widget/textfield_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditInforPage extends StatefulWidget {
  const EditInforPage({super.key});

  @override
  State<EditInforPage> createState() => _EditInforPageState();
}

class _EditInforPageState extends State<EditInforPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(FontAwesomeIcons.chevronLeft),
        ),
        leadingWidth: 80,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: Size(45, 30),
                elevation: 3,
              ),
              icon: Icon(
                FontAwesomeIcons.gear,
                color: Colors.white,
                size: 15,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
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
                        child: Text('Upload Image'),
                      ),
                    ],
                  ),
                )
              ],
            ),
            TextFieldItem(
              label: 'FullName',
              labelhint: 'Nguyễn Trần Duy Tân',
            ),
            SizedBox(height: 20),
            TextFieldItem(
              label: 'Phone',
              labelhint: '0399441272',
            ),
            SizedBox(height: 20),
            TextFieldItem(
              label: 'Address',
              labelhint: '227/669 Nguyễn Tư Giản p12 quận Gò Vấp',
            ),
            SizedBox(height: 20),
            TextFieldItem(
              label: 'City',
              labelhint: 'Hồ Chí Minh',
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text(
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
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    backgroundColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text(
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
    );
  }
}
