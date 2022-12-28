import 'package:domain/domain.dart';

class FavouriteMeetingRoomModel {
  String? likeableType;
  MeetingRoomItem? orderable;
  FavouriteMeetingRoomModel({this.likeableType, this.orderable});
  factory FavouriteMeetingRoomModel.fromJson(Map<String, dynamic> json) =>
      FavouriteMeetingRoomModel(
        likeableType: json['likeable_type'],
        orderable: json['orderable'] == null ? null : MeetingRoomItem.fromJson(json['orderable']),
      );
  Map<String, dynamic> toJson() => {
        'likeable_type': likeableType,
        'orderable': orderable,
      };
}
