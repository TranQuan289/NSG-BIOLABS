import 'package:domain/models/metadata.dart';
import 'package:domain/models/site.dart';

class NewMeetingRoomModel {
  NewMeetingRoomModel({
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
  List<MeetingRoomItem> data;

  factory NewMeetingRoomModel.fromJson(Map<String, dynamic> json) => NewMeetingRoomModel(
        metadata: Metadata.fromJson(json['metadata']),
        message: json['message'],
        code: json['code'],
        status: json['status'],
        data: json['data'] == null
            ? []
            : List<MeetingRoomItem>.from(json['data'].map((x) => MeetingRoomItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'metadata': metadata?.toJson(),
        'message': message,
        'code': code,
        'status': status,
        'data': List<MeetingRoomItem>.from(data.map((x) => x.toJson())),
      };
}

class MeetingRoomItem {
  MeetingRoomItem({
    this.id,
    this.name,
    this.site,
    required this.isLiked,
  });

  int? id;
  String? name;
  Site? site;
  bool? isLiked;

  factory MeetingRoomItem.fromJson(Map<String, dynamic> json) => MeetingRoomItem(
        id: json['id'],
        name: json['name'],
        site: json['site'] == null ? null : Site.fromJson(json['site']),
        isLiked: json['is_liked'] ?? true,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'site': site?.toJson(),
        'is_liked': isLiked,
      };
}
