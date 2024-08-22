import 'package:flutter/material.dart';

showAlertDialog({
  required BuildContext context,
  required String message,
  String? btnText,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(
            message,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).listTileTheme.textColor,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                btnText ?? "OK",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      });
}
