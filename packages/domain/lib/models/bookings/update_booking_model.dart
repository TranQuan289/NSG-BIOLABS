import 'package:domain/models/metadata.dart';
import 'package:domain/models/orderable.dart';

class UpdateBookingModel {
  UpdateBookingModel({
    this.metadata,
    this.message,
    this.code,
    this.status,
    required this.data,
  });

  Metadata? metadata;
  String? message;
  int? code;
  bool? status;
  UpdateBooking? data;

  factory UpdateBookingModel.fromJson(Map<String, dynamic> json) => UpdateBookingModel(
        metadata: json['metadata'],
        message: json['message'],
        code: json['code'],
        status: json['status'],
        data: json['data'] == null ? null : UpdateBooking.fromJson(json['data']),
      );
}

class UpdateBooking {
  UpdateBooking({
    this.id,
    this.orderableType,
    this.startDate,
    this.startTime,
    this.startDatetime,
    this.endDate,
    this.endTime,
    this.endDatetime,
    this.duration,
    this.orderable,
  });

  int? id;
  String? orderableType;
  DateTime? startDate;
  int? startTime;
  DateTime? startDatetime;
  DateTime? endDate;
  int? endTime;
  DateTime? endDatetime;
  int? duration;
  Orderable? orderable;

  factory UpdateBooking.fromJson(Map<String, dynamic> json) => UpdateBooking(
        id: json['id'],
        orderableType: json['orderable_type'],
        startDate: DateTime.parse(json['start_date']),
        startTime: json['start_time'],
        startDatetime: DateTime.parse(json['start_datetime']),
        endDate: DateTime.parse(json['end_date']),
        endTime: json['end_time'],
        endDatetime: DateTime.parse(json['end_datetime']),
        duration: json['duration'],
        orderable: json['orderable'] == null ? null : Orderable.fromJson(json['orderable']),
      );
}
