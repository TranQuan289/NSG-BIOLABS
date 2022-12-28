import 'package:flutter/material.dart';

class TextWidgetEditBooking extends StatelessWidget {
  final String data;
  final TextStyle? textStyle;
  final int? maxLinesText;
  final TextOverflow? textOverflow;
  final bool? softWrap;
  const TextWidgetEditBooking({
    Key? key,
    required this.data,
    this.textStyle,
    this.maxLinesText,
    this.textOverflow,
    this.softWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: textStyle,
      maxLines: maxLinesText,
      overflow: textOverflow,
      softWrap: softWrap,
    );
  }
}
