import 'package:domain/domain.dart';

class FavouriteEquipmentModel {
  String? likeableType;
  EquipmentItem? orderable;
  FavouriteEquipmentModel({this.likeableType, this.orderable});
  factory FavouriteEquipmentModel.fromJson(Map<String, dynamic> json) => FavouriteEquipmentModel(
        likeableType: json['likeable_type'],
        orderable: json['orderable'] == null ? null : EquipmentItem.fromJson(json['orderable']),
      );
  Map<String, dynamic> toJson() => {
        'likeable_type': likeableType,
        'orderable': orderable,
      };
}
