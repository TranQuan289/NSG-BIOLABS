import 'package:flutter/material.dart';

class TextWidgetItemFavourite extends StatelessWidget {
  final String data;

  final TextStyle? textStyle;
  const TextWidgetItemFavourite({super.key, required this.data, this.textStyle});

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
