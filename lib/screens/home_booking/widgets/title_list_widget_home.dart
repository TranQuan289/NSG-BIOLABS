import 'package:flutter/material.dart';
import 'package:shared_ui/styles/index.dart';

class TitleListWidgetHome extends StatelessWidget {
  final String titleListBooking;
  const TitleListWidgetHome({super.key, required this.titleListBooking});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          titleListBooking,
          style: myUpComingBookingsTextStyle,
        ),
      ),
    );
  }
}
