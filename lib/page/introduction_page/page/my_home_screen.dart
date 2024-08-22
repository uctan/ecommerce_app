import 'package:app_ecomerce/page/introduction_page/screens/screens_1.dart';
import 'package:app_ecomerce/page/introduction_page/screens/screens_2.dart';
import 'package:app_ecomerce/page/introduction_page/screens/screens_3.dart';
import 'package:app_ecomerce/page/introduction_page/screens/screens_4.dart';
import 'package:app_ecomerce/page/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  PageController pageController = PageController();
  String buttonText = "Skip";
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              currentPageIndex = index;
              if (index == 3) {
                buttonText = "Finish";
              } else {
                buttonText = "Skip";
              }
              setState(() {});
            },
            children: [
              Screen1(),
              Screen2(),
              Screen3(),
              Screen4(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                currentPageIndex == 3
                    ? SizedBox()
                    : GestureDetector(
                        onTap: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text('Next'),
                      ),
                SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                ),
                GestureDetector(
                  onTap: () {
                    if (currentPageIndex == 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    } else {
                      pageController.jumpToPage(3);
                    }
                  },
                  child: Text(buttonText),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
