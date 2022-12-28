import 'package:flutter/material.dart';
import 'package:shared_ui/styles/text_style.dart';

class ReusableDialog {
  static show(
    BuildContext context, {
    required String title,
    String? body,
    String? labelLeft,
    TextStyle? styleLeft,
    Function()? onPressLeft,
    String? labelRight,
    TextStyle? styleRight,
    Function()? onPressRight,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: titleDetailsTextStyle,
          ),
          content: Text(
            body ?? '',
            style: normalHintTextStyle,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: onPressLeft,
                  child: Text(
                    labelLeft ?? '',
                    style: styleLeft,
                  ),
                ),
                TextButton(
                  onPressed: onPressRight,
                  child: Text(labelRight ?? '', style: styleRight),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
