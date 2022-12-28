import 'package:domain/models/metadata.dart';
import 'package:domain/models/orderable.dart';

class OngoingBookingModel {
  OngoingBookingModel({
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
  List<OngoingBooking> data;

  factory OngoingBookingModel.fromJson(Map<String, dynamic> json) => OngoingBookingModel(
        metadata: json['metadata'] == null ? null : Metadata.fromJson(json['metadata']),
        message: json['message'],
        code: json['code'],
        status: json['status'],
        data: json['data'] == null
            ? []
            : List<OngoingBooking>.from(json['data'].map((x) => OngoingBooking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'metadata': metadata?.toJson(),
        'message': message,
        'code': code,
        'status': status,
        'data': List<OngoingBooking>.from(data.map((x) => x.toJson())),
      };
}

class OngoingBooking {
  OngoingBooking({
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
  double? startTime;
  DateTime? startDatetime;
  DateTime? endDate;
  double? endTime;
  DateTime? endDatetime;
  double? duration;
  Orderable? orderable;

  factory OngoingBooking.fromJson(Map<String, dynamic> json) => OngoingBooking(
        id: json['id'],
        orderableType: json['orderable_type'],
        startDate: DateTime.parse(json['start_date']),
        startTime: json['start_time'].toDouble(),
        startDatetime: DateTime.parse(json['start_datetime']),
        endDate: DateTime.parse(json['end_date']),
        endTime: json['end_time'].toDouble(),
        endDatetime: DateTime.parse(json['end_datetime']),
        duration: json['duration'],
        orderable: json['orderable'] == null ? null : Orderable.fromJson(json['orderable']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderable_type': orderableType,
        'start_date':
            "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
        'start_time': startTime,
        'start_datetime': startDatetime?.toIso8601String(),
        'end_date':
            "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
        'end_time': endTime,
        'end_datetime': endDatetime?.toIso8601String(),
        'duration': duration,
        'orderable': orderable?.toJson(),
      };
}
