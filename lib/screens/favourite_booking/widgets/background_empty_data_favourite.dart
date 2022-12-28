import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import 'index.dart';

class BackgroundEmptyDataFavourite extends StatelessWidget {
  final String notificationData;
  final String startMessageRequiredData;
  final String endMessageRequiredData;
  final bool visibility;
  const BackgroundEmptyDataFavourite({
    super.key,
    required this.notificationData,
    required this.startMessageRequiredData,
    required this.endMessageRequiredData,
    required this.visibility,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Column(
              children: [
                TextWidgetItemFavourite(
                  data: notificationData,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextWidgetItemFavourite(
                        data: startMessageRequiredData,
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.favorite,
                      size: 20,
                      color: greenColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextWidgetItemFavourite(
                        data: endMessageRequiredData,
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
