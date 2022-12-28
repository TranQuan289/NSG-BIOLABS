import 'package:flutter/material.dart';

class TextWidgetTabFavourite extends StatelessWidget {
  final String data;

  final TextStyle? textStyle;
  const TextWidgetTabFavourite({super.key, required this.data, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: textStyle,
      softWrap: true,
    );
  }
}
