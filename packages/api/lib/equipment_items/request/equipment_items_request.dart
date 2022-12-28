import 'package:api/api.dart';
import 'package:dio/dio.dart';

class EquipmentRequest {
  EquipmentRequest._();
  static APIRequest getNewBookingEquipmentItems({
    int? page,
    int? perPage,
    List<int>? levels,
    List<int>? sites,
    List<int>? types,
    String? keywords,
  }) {
    return APIRequest(
      method: HTTPMethods.get,
      path: '/equipment_items',
      parameters: {
        'page': page,
        'per_page': perPage,
        'keywords': keywords,
      },
      body: FormData.fromMap({
        'levels': levels,
        'sites': sites,
        'types': types,
      }),
    );
  }

  
  static APIRequest toggleLikeNewBookingEquipmentItem({
    required int id,
  }) {
    return APIRequest(
      method: HTTPMethods.post,
      path: '/equipment_items/$id/toggle_like',
      parameters: {
        'id': id,
      },
    );
  }

  
}
