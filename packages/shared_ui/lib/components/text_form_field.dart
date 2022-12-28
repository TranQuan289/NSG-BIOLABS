// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    required this.textCotroller,
    required this.hintLabel,
    super.key,
    required this.iconPassword,
    required this.isEnabled,
  });
  final TextEditingController textCotroller;
  final String hintLabel;
  final bool isEnabled;
  final bool iconPassword;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool isCheckPass = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.isEnabled,
      controller: widget.textCotroller,
      obscureText: widget.iconPassword ? isCheckPass : false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 21, top: 17, bottom: 17),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: borderColor, width: 1.0),
          ),
          filled: true,
          hintStyle: normalHintTextStyle,
          suffixIcon: widget.iconPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isCheckPass = !isCheckPass;
                    });
                  },
                  icon: isCheckPass
                      ? Image.asset(
                          ImagePath.eyePassClose.assetName,
                          height: 20,
                          width: 20,
                        )
                      : Icon(
                          Icons.remove_red_eye_sharp,
                          size: 20,
                          color: greenColor,
                        ))
              : null,
          hintText: widget.hintLabel,
          fillColor: widget.isEnabled ? primaryColor : borderColor),
    );
  }
}
