import 'package:flutter/material.dart';

class LoginOption extends StatelessWidget {
  const LoginOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BuildButton(
          iconImage: Image(
            image: AssetImage('assets/icons/fb.png'),
            height: 20,
            width: 20,
          ),
          textButton: 'Facebook',
        ),
        BuildButton(
          iconImage: Image(
            image: AssetImage('assets/icons/instagram.jfif'),
            height: 20,
            width: 20,
          ),
          textButton: 'Instagram',
        ),
      ],
    );
  }
}

class BuildButton extends StatelessWidget {
  const BuildButton({
    super.key,
    required this.iconImage,
    required this.textButton,
  });
  final Image iconImage;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.06,
      width: mediaQuery.width * 0.36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconImage,
          SizedBox(width: 5),
          Text(textButton),
        ],
      ),
    );
  }
}
