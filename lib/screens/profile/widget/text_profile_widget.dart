import 'package:flutter/material.dart';

class TextProfileWidget extends StatelessWidget {
  const TextProfileWidget({required this.label, required this.textStyle, Key? key})
      : super(key: key);
  final String label;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: textStyle,
    );
  }
}
