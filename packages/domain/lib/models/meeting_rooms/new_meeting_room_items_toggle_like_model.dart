import 'package:domain/models/metadata.dart';
import 'package:domain/models/site.dart';

class NewMeetingRoomsItemsToggleLikeModel {
  NewMeetingRoomsItemsToggleLikeModel({
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
  MeetingRoomItemToggleLike? data;

  factory NewMeetingRoomsItemsToggleLikeModel.fromJson(Map<String, dynamic> json) =>
      NewMeetingRoomsItemsToggleLikeModel(
        metadata: json['metadata'] == null ? null : Metadata.fromJson(json['metadata']),
        message: json['message'],
        code: json['code'],
        status: json['status'],
        data: json['data'] == null ? null : MeetingRoomItemToggleLike.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'metadata': metadata,
        'message': message,
        'code': code,
        'status': status,
        'data': data?.toJson(),
      };
}

class MeetingRoomItemToggleLike {
  MeetingRoomItemToggleLike({
    this.id,
    this.name,
    this.site,
    required this.isLiked,
  });

  int? id;
  String? name;
  Site? site;
  bool isLiked;

  factory MeetingRoomItemToggleLike.fromJson(Map<String, dynamic> json) =>
      MeetingRoomItemToggleLike(
        id: json['id'],
        name: json['name'],
        site: json['site'] == null ? null : Site.fromJson(json['site']),
        isLiked: json['is_liked'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'site': site?.toJson(),
        'is_liked': isLiked,
      };
}
