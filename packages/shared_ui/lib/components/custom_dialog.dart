import 'package:flutter/material.dart';
import 'package:shared_ui/colors/index.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback? onTapBackButton;
  final VoidCallback? onTapConfirmButton;
  final bool? visibleBackButton;
  final bool? visibleConfirmButton;
  final bool? visibleDialogMessage;
  final bool? visibleErrorMessage;
  final String? stringBackButton;
  final String? stringConfirmButton;
  final String? errorMessage;
  final String? askingString;
  final String? undoString;
  final double? height;
  final Color? colorConfirmButton;
  const CustomDialog({
    super.key,
    this.height,
    this.onTapBackButton,
    this.onTapConfirmButton,
    this.stringBackButton,
    this.stringConfirmButton,
    this.errorMessage,
    this.colorConfirmButton,
    this.askingString,
    this.undoString,
    required this.visibleBackButton,
    required this.visibleConfirmButton,
    required this.visibleDialogMessage,
    required this.visibleErrorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 39, 30, 33),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Visibility(
                      visible: visibleDialogMessage ?? false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            askingString ?? '',
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            undoString ?? '',
                            textAlign: TextAlign.justify,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 18,
                              color: greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: visibleErrorMessage ?? false,
                      child: Text(
                        errorMessage ?? '',
                        maxLines: 10,
                        style: const TextStyle(
                          height: 1.3,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: visibleBackButton ?? false,
                        child: GestureDetector(
                          onTap: onTapBackButton,
                          child: Text(
                            stringBackButton ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: blackColor,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: visibleConfirmButton ?? false,
                        child: GestureDetector(
                          onTap: onTapConfirmButton,
                          child: Text(
                            stringConfirmButton ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: colorConfirmButton,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
