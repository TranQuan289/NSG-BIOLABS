import 'package:domain/models/additionals.dart';
import 'package:domain/models/company.dart';
import 'package:domain/models/equipment_type.dart';
import 'package:domain/models/metadata.dart';
import 'package:domain/models/site.dart';

class DetailsBookingModel {
  DetailsBookingModel({
    this.metadata,
    this.message,
    this.code,
    this.status,
    this.config,
    required this.data,
  });

  Metadata? metadata;
  String? message;
  int? code;
  bool? status;
  Config? config;
  List<DetailsBooking> data;

  factory DetailsBookingModel.fromJson(Map<String, dynamic> json) => DetailsBookingModel(
        metadata: json['metadata'] == null ? null : Metadata.fromJson(json['metadata']),
        message: json['message'],
        code: json['code'],
        status: json['status'],
        config: json['config'] == null ? null : Config.fromJson(json['config']),
        data: json['data'] == null
            ? []
            : List<DetailsBooking>.from(json['data'].map((x) => DetailsBooking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'metadata': metadata,
        'message': message,
        'code': code,
        'status': status,
        'config': config?.toJson(),
        'data': List<DetailsBooking>.from(data.map((x) => x.toJson())),
      };
}

class Config {
  Config({
    this.model,
    this.step,
    this.mode,
    this.menuWidth,
    this.dayWidth,
    this.name,
    this.site,
    this.targetMin,
    this.targetMax,
    this.startTime,
    this.endTime,
    this.countDay,
    this.arrDate,
  });

  String? model;
  int? step;
  String? mode;
  int? menuWidth;
  int? dayWidth;
  String? name;
  String? site;
  int? targetMin;
  int? targetMax;
  DateTime? startTime;
  DateTime? endTime;
  int? countDay;
  List<String>? arrDate;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        model: json['model'],
        step: json['step'],
        mode: json['mode'],
        menuWidth: json['menu_width'],
        dayWidth: json['day_width'],
        name: json['name'],
        site: json['site'],
        targetMin: json['target_min'],
        targetMax: json['target_max'],
        startTime: DateTime.parse(json['start_time']),
        endTime: DateTime.parse(json['end_time']),
        countDay: json['count_day'],
        arrDate: json['arr_date'] == null ? [] : List<String>.from(json['arr_date'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'model': model,
        'step': step,
        'mode': mode,
        'menu_width': menuWidth,
        'day_width': dayWidth,
        'name': name,
        'site': site,
        'target_min': targetMin,
        'target_max': targetMax,
        'start_time': startTime?.toIso8601String(),
        'end_time': endTime?.toIso8601String(),
        'count_day': countDay,
        'arr_date': List<String>.from(arrDate!.map((x) => x)),
      };
}

class DetailsBooking {
  DetailsBooking({
    this.id,
    this.name,
    this.buildingName,
    this.status,
    this.isLiked,
    this.site,
    this.equipmentType,
    this.bookings,
    this.additionals,
  });

  int? id;
  String? name;
  String? buildingName;
  String? status;
  bool? isLiked;
  Site? site;
  EquipmentType? equipmentType;
  List<Booking>? bookings;
  List<Additionals>? additionals;

  factory DetailsBooking.fromJson(Map<String, dynamic> json) => DetailsBooking(
        id: json['id'],
        name: json['name'],
        buildingName: json['building_name'],
        status: json['status'],
        isLiked: json['is_liked'],
        site: json['site'] == null ? null : Site.fromJson(json['site']),
        equipmentType:
            json['equipment_type'] == null ? null : EquipmentType.fromJson(json['equipment_type']),
        bookings: json['bookings'] == null
            ? []
            : List<Booking>.from(json['bookings'].map((x) => Booking.fromJson(x))),
        additionals: json['additionals'] == null
            ? []
            : List<Additionals>.from(json['additionals'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'building_name': buildingName,
        'status': status,
        'is_liked': isLiked,
        'site': site?.toJson(),
        'equipment_type': equipmentType?.toJson(),
        'bookings': List<Booking>.from(bookings!.map((x) => x.toJson())),
        'additionals': List<Additionals>.from(additionals!.map((x) => x)),
      };
}

class Booking {
  Booking({
    this.id,
    this.mode,
    this.orderableType,
    this.orderableId,
    this.startDatetime,
    this.endDatetime,
    this.duration,
    this.status,
    this.user,
    this.isCheckedOut,
  });

  int? id;
  String? mode;
  String? orderableType;
  int? orderableId;
  DateTime? startDatetime;
  DateTime? endDatetime;
  int? duration;
  String? status;
  User? user;
  bool? isCheckedOut;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json['id'],
        mode: json['mode'],
        orderableType: json['orderable_type'],
        orderableId: json['orderable_id'],
        startDatetime: DateTime.parse(json['start_datetime']),
        endDatetime: DateTime.parse(json['end_datetime']),
        duration: json['duration'],
        status: json['status'],
        user: json['user'] == null ? null : User.fromJson(json['user']),
        isCheckedOut: json['is_checked_out'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'mode': mode,
        'orderable_type': orderableType,
        'orderable_id': orderableId,
        'start_datetime': startDatetime?.toIso8601String(),
        'end_datetime': endDatetime?.toIso8601String(),
        'duration': duration,
        'status': status,
        'user': user?.toJson(),
        'is_checked_out': isCheckedOut,
      };
}

class User {
  User({
    this.id,
    this.email,
    this.fullName,
    this.icon,
    this.company,
  });

  int? id;
  String? email;
  String? fullName;
  String? icon;
  Company? company;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        email: json['email'],
        fullName: json['full_name'],
        icon: json['icon'],
        company: json['company'] == null ? null : Company.fromJson(json['company']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'full_name': fullName,
        'icon': icon,
        'company': company?.toJson(),
      };
}
