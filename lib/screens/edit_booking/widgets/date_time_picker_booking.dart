import 'package:flutter/cupertino.dart';
import 'package:shared_ui/colors/index.dart';

class DateTimePickerBooking extends StatelessWidget {
  final VoidCallback? onPressDone;
  final VoidCallback? onPressCancel;
  final CupertinoDatePickerMode modeDateTimePicker;
  final DateTime? initialDateTime;
  final void Function(DateTime) onDateTimeChanged;
  final int? minuteInterval;
  const DateTimePickerBooking({
    super.key,
    this.onPressDone,
    this.onPressCancel,
    required this.modeDateTimePicker,
    this.initialDateTime,
    required this.onDateTimeChanged,
    this.minuteInterval,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      color: primaryColor,
      child: Column(
        children: [
          SizedBox(
            height: 29,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                  onPressed: onPressCancel,
                  child: Text('Cancel', style: TextStyle(color: greyColor, fontSize: 16)),
                ),
                CupertinoButton(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                  onPressed: onPressDone,
                  child: const Text('Done', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
          Expanded(
            child: CupertinoDatePicker(
              minuteInterval: minuteInterval ?? 1,
              mode: modeDateTimePicker,
              onDateTimeChanged: onDateTimeChanged,
              initialDateTime: initialDateTime,
              minimumYear: 1900,
              maximumYear: 2100,
            ),
          ),
        ],
      ),
    );
  }
}
