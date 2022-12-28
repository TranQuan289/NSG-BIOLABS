import 'package:flutter/material.dart';

class TextWidgetItemNewBooking extends StatelessWidget {
  final String data;

  final TextStyle? textStyle;
  const TextWidgetItemNewBooking({super.key, required this.data, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: textStyle,
      maxLines: 5,
      softWrap: true,
    );
  }
}
