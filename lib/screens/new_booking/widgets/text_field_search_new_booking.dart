import 'package:flutter/material.dart';
import 'package:shared_ui/colors/colors.dart';

import '../decoration/index.dart';

class TextFieldSearchNewBooking extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController controller;
  const TextFieldSearchNewBooking({super.key, this.onChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 23, 24, 14),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: greyColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
          hintText: 'Search',
          hintStyle: TextStyle(color: greyColor, fontSize: 16),
          suffixIcon: Icon(
            Icons.search,
            color: greyColor,
          ),
          enabledBorder: outlineBorder,
          focusedBorder: outlineBorder,
        ),
      ),
    );
  }
}
