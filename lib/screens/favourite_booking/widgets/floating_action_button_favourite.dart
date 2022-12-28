import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class FloatingActionButtonFavourite extends StatelessWidget {
  final VoidCallback? onPressed;
  const FloatingActionButtonFavourite({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 9, 64),
      child: SizedBox(
        width: 62,
        height: 62,

        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: greenColor,
          child: Icon(
            Icons.add,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
