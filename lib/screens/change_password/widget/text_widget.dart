import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({required this.label, Key? key}) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: normalBlackTextStyle,
    );
  }
}
