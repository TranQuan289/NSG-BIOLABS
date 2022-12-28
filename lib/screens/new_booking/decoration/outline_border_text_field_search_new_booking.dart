import 'package:flutter/material.dart';
import 'package:shared_ui/colors/index.dart';

OutlineInputBorder outlineBorder = OutlineInputBorder(
  borderRadius: const BorderRadius.all(Radius.circular(5)),
  borderSide: BorderSide(
    style: BorderStyle.solid,
    width: 1,
    color: lightGreyColor,
  ),
);
