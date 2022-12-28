import 'package:domain/models/additionals.dart';
import 'package:domain/models/equipment_type.dart';
import 'package:domain/models/metadata.dart';
import 'package:domain/models/site.dart';

class NewEquipmentItemsToggleLikeModel {
  NewEquipmentItemsToggleLikeModel({
    this.metadata,
    this.message,
    this.code,
    this.status,
    this.data,
  });

  Metadata? metadata;
  String? message;
  int? code;
  bool? status;
  EquipmentItemToggleLike? data;

  factory NewEquipmentItemsToggleLikeModel.fromJson(Map<String, dynamic> json) =>
      NewEquipmentItemsToggleLikeModel(
        metadata: json['metadata'] == null ? null : Metadata.fromJson(json['metadata']),
        message: json['message'],
        code: json['code'],
        status: json['status'],
        data: json['data'] == null ? null : EquipmentItemToggleLike.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'metadata': metadata,
        'message': message,
        'code': code,
        'status': status,
        'data': data?.toJson(),
      };
}

class EquipmentItemToggleLike {
  EquipmentItemToggleLike({
    this.id,
    this.name,
    this.startTimeAvailable,
    this.endTimeAvailable,
    this.minDurationPeriod,
    this.maxDurationPeriod,
    this.site,
    this.equipmentType,
    this.additionals,
    required this.isLiked,
  });

  int? id;
  String? name;
  double? startTimeAvailable;
  double? endTimeAvailable;
  double? minDurationPeriod;
  double? maxDurationPeriod;
  Site? site;
  EquipmentType? equipmentType;
  List<Additionals>? additionals;
  bool isLiked;

  factory EquipmentItemToggleLike.fromJson(Map<String, dynamic> json) => EquipmentItemToggleLike(
        id: json['id'],
        name: json['name'],
        startTimeAvailable: json['start_time_available'],
        endTimeAvailable: json['end_time_available'],
        minDurationPeriod: json['min_duration_period'],
        maxDurationPeriod: json['max_duration_period'],
        site: json['site'] == null ? null : Site.fromJson(json['site']),
        equipmentType:
            json['equipment_type'] == null ? null : EquipmentType.fromJson(json['equipment_type']),
        additionals: json['additionals'] == null
            ? []
            : List<Additionals>.from(json['additionals'].map((x) => x)),
        isLiked: json['is_liked'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'start_time_available': startTimeAvailable,
        'end_time_available': endTimeAvailable,
        'min_duration_period': minDurationPeriod,
        'max_duration_period': maxDurationPeriod,
        'site': site?.toJson(),
        'equipment_type': equipmentType?.toJson(),
        'additionals': List<Additionals>.from(additionals!.map((x) => x)),
        'is_liked': isLiked,
      };
}
