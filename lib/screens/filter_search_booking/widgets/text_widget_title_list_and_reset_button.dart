import 'package:flutter/material.dart';
import 'package:shared_ui/colors/index.dart';

class TextWidgetTitleListAndResetButton extends StatelessWidget {
  final String dataTitleListFilter;
  final String dataTextButton;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTapResetButton;
  const TextWidgetTitleListAndResetButton(
      {super.key,
      this.onTapResetButton,
      required this.dataTitleListFilter,
      required this.dataTextButton,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      // const EdgeInsets.fromLTRB(24, 20, 24, 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dataTitleListFilter, //
            style: TextStyle(
              color: blackColor,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          GestureDetector(
            onTap: onTapResetButton, //
            child: Text(
              dataTextButton, //
              style: TextStyle(
                color: greenColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
