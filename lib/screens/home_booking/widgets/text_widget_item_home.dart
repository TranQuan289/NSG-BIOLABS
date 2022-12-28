import 'package:flutter/material.dart';

class TextWidgetItemHome extends StatelessWidget {
  final String data;

  final TextStyle? textStyle;
  const TextWidgetItemHome({super.key, required this.data, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: textStyle,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
