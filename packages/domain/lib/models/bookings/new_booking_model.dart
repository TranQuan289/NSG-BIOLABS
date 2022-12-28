import 'package:domain/models/metadata.dart';
import 'package:domain/models/orderable.dart';

class NewBookingModel {
  NewBookingModel({
    this.metadata,
    this.code,
    this.status,
    this.data,
  });

  Metadata? metadata;
  int? code;
  bool? status;
  NewBooking? data;

  factory NewBookingModel.fromJson(Map<String, dynamic> json) => NewBookingModel(
        metadata: json['metadata'] == null ? null : Metadata.fromJson(json['metadata']),
        code: json['code'],
        status: json['status'],
        data: json['data'] == null ? null : NewBooking.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'metadata': metadata,
        'code': code,
        'status': status,
        'data': data?.toJson(),
      };
}

class Messages {
  Messages({
    this.startDatetime,
    this.endDatetime,
  });
  List<String>? startDatetime;
  List<String>? endDatetime;
  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        startDatetime: json['startDatetime'] ?? [],
        endDatetime: json['endDatetime'] ?? [],
      );
}

class NewBooking {
  NewBooking({
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

  factory NewBooking.fromJson(Map<String, dynamic> json) => NewBooking(
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
