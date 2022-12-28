import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

ButtonStyle greenButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 16)),
  backgroundColor: MaterialStateProperty.all(greenColor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: BorderSide.none)),
);
ButtonStyle greenBorderButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 16)),
  backgroundColor: MaterialStateProperty.all(primaryColor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: BorderSide.none)),
);
ButtonStyle disableButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 16)),
  backgroundColor: MaterialStateProperty.all(hintColor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
      side: BorderSide.none,
    ),
  ),
);

ButtonStyle redButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 15)),
  backgroundColor: MaterialStateProperty.all(redColor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: BorderSide.none)),
);
