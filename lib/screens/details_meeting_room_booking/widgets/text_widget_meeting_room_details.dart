import 'package:flutter/material.dart';

class TextWidgetMeetingRoomDetails extends StatelessWidget {
  final String data;
  final TextStyle? textStyle;
  const TextWidgetMeetingRoomDetails({super.key, required this.data, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: textStyle,
    );
  }
}
