import 'package:flutter/material.dart';

class TextWidgetInfo extends StatelessWidget {
  final String data;
  final TextStyle? textStyle;
  const TextWidgetInfo({super.key, required this.data, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: textStyle,
      maxLines: 5,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }
}
