import 'package:flutter/material.dart';

class TextWidgetEquipmentDetails extends StatelessWidget {
  final String data;
  final TextStyle? textStyle;
  const TextWidgetEquipmentDetails({super.key, required this.data, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: textStyle,
    );
  }
}
