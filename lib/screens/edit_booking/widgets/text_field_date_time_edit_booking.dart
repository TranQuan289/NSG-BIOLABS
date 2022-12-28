import 'package:flutter/material.dart';
import 'package:shared_ui/colors/index.dart';

import '../decoration/index.dart';

class TextFieldDateTimeEditBooking extends StatelessWidget {
  final bool? hasBackGroundColor;
  final Color? backgroundColor;
  final Widget? childIcon;
  final VoidCallback? onTapDate;
  final VoidCallback? onTapTime;
  final Widget? childTextDate;
  final Widget? childTextTime;
  const TextFieldDateTimeEditBooking({
    super.key,
    this.hasBackGroundColor,
    this.backgroundColor,
    this.childIcon,
    this.onTapDate,
    this.onTapTime,
    this.childTextDate,
    this.childTextTime,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 369,
          height: 50,
          child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              filled: hasBackGroundColor, // true
              fillColor: backgroundColor, // superLightGreyColor
              suffixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 21, 0),
                child: childIcon,
              ),
              enabledBorder: outlineBorderTextFieldEditBooking,
              focusedBorder: outlineBorderTextFieldEditBooking,
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onTapDate,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 16, 0),
                  child: childTextDate,
                ),
              ),
              Container(
                width: 2,
                height: 17,
                color: lightGreyColor,
              ),
              GestureDetector(
                onTap: onTapTime,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: childTextTime,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
