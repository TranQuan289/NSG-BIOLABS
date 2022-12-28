import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import 'index.dart';

class BackGroundEmptyDataHome extends StatelessWidget {
  final String notificationData;
  final String startMessageRequiredData;
  final String endMessageRequiredData;
  final bool visibility;
  const BackGroundEmptyDataHome(
      {super.key,
      required this.notificationData,
      required this.startMessageRequiredData,
      required this.endMessageRequiredData,
      required this.visibility});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Column(
        children: [
          Flexible(
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: -87,
                  child: Image.asset(
                    ImagePath.polygon4.assetName,
                    width: 320,
                    height: 277,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: -32,
                  child: Image.asset(
                    ImagePath.polygon3.assetName,
                    width: 250,
                    height: 277,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              children: [
                TextWidgetItemHome(
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
                      child: TextWidgetItemHome(
                        data: startMessageRequiredData,
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: greenColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add_sharp,
                        size: 20,
                        color: primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextWidgetItemHome(
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
          const SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }
}
