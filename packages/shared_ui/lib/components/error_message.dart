import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 24),
        decoration: BoxDecoration(
          color: errorColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(children: [
          Icon(
            Icons.error_outline_sharp,
            color: redColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: normalBlackTextStyle,
            ),
          ),
        ]),
      ),
    );
  }
}
