import 'package:domain/models/additionals.dart';
import 'package:domain/models/equipment_type.dart';
import 'package:domain/models/site.dart';

class Orderable {
  Orderable({
    this.id,
    this.name,
    this.startTimeAvailable,
    this.endTimeAvailable,
    this.minDurationPeriod,
    this.maxDurationPeriod,
    this.site,
    this.equipmentType,
    this.additionals,
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

  factory Orderable.fromJson(Map<String, dynamic> json) => Orderable(
        id: json['id'],
        name: json['name'],
        startTimeAvailable: json['start_time_available'] ?? 0,
        endTimeAvailable: json['end_time_available'] ?? 0,
        minDurationPeriod: json['min_duration_period'] ?? 0,
        maxDurationPeriod: json['max_duration_period'] ?? 0,
        site: json['site'] == null ? null : Site.fromJson(json['site']),
        equipmentType:
            json['equipment_type'] == null ? null : EquipmentType.fromJson(json['equipment_type']),
        additionals: json['additionals'] == null
            ? []
            : List<Additionals>.from(json['additionals'].map((x) => x)),
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
      };
}
