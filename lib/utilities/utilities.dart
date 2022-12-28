import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utilities {
  Utilities();

  String timeFormat(DateTime dateTime) {
    DateTime newDateTime = DateTime.parse(dateTime.toIso8601String()).toLocal();
    var newDateTimeFormat = DateFormat('hh:mm a').format(newDateTime);
    return newDateTimeFormat;
  }

  String dateFormat(DateTime dateTime, String pattern) {
    var dateFormat = DateFormat(pattern).format(dateTime);
    return dateFormat;
  }

  DateTime displayToTime(DateTime fromTime, DateTime fromDate) {
    if (fromTime.toString().contains('23')) {
      return fromDate.add(const Duration(days: 1));
    } else {
      return fromDate;
    }
  }

  String validateDateTime(
    DateTime fromDate,
    DateTime toDate,
    DateTime fromTime,
    DateTime toTime,
  ) {
    var currentFromDate = DateTime(fromDate.year, fromDate.month, fromDate.day);
    var currentToDate = DateTime(toDate.year, toDate.month, toDate.day);
    if (currentFromDate.compareTo(currentToDate) > 0) {
      return 'Timeslot Unavailable';
    } else if (currentFromDate.compareTo(currentToDate) < 0) {
      return 'Timeslot Available';
    } else if (currentFromDate.compareTo(currentToDate) == 0 &&
        toTime.hour.compareTo(fromTime.hour) <= 0) {
      return 'Timeslot Unavailable';
    } else if (currentFromDate.compareTo(currentToDate) == 0 &&
        toTime.hour.compareTo(fromTime.hour) > 0) {
      if (toTime.difference(fromTime).inMinutes < 60) {
        return 'Timeslot Unavailable';
      } else {
        return 'Timeslot Available';
      }
    } else {
      return 'Timeslot Unavailable';
    }
  }

  bool checkDateTime(
    DateTime fromDate,
    DateTime toDate,
    DateTime fromTime,
    DateTime toTime,
  ) {
    var currentFromDate = DateTime(fromDate.year, fromDate.month, fromDate.day);
    var currentToDate = DateTime(toDate.year, toDate.month, toDate.day);
    if (currentFromDate.compareTo(currentToDate) > 0) {
      return false;
    } else if (currentFromDate.compareTo(currentToDate) < 0) {
      return true;
    } else if (currentFromDate.compareTo(currentToDate) == 0 &&
        toTime.hour.compareTo(fromTime.hour) <= 0) {
      return false;
    } else if (currentFromDate.compareTo(currentToDate) == 0 &&
        toTime.hour.compareTo(fromTime.hour) > 0) {
      if (toTime.difference(fromTime).inMinutes < 60) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  double convertTimeToDouble(DateTime time) {
    var stringTime = '${time.hour}.${time.minute}';
    var doubleTime = double.parse(stringTime);
    return doubleTime;
  }

  DateTime convertDate(DateTime date) {
    return DateUtils.dateOnly(date);
  }

  String formatErrorMessage(String errorMessage) {
    return '- ${errorMessage.replaceAll(', ', '\n- ')}';
  }

  DateTime convertDoubleToTime(double time) {
    String doubleString = time.toStringAsFixed(2);
    String timeString = doubleString.toString().replaceAll('.', ':');
    DateTime newTime = DateFormat('HH:mm').parse(timeString);
    return newTime;
  }
}
