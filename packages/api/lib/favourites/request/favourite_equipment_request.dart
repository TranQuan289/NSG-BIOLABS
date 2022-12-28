import 'package:api/api.dart';
class FavouriteEquipmentRequest {
  FavouriteEquipmentRequest._();
  static APIRequest getFavouriteEquipmentItems({
    int? page,
    int? perPage,
    required String dataMode,
  }) {
    return APIRequest(
      method: HTTPMethods.get,
      path: '/favorites',
      parameters: {
        'page': page,
        'per_page': perPage,
        'data_mode': dataMode,
      },
    );
  }

  static APIRequest toggleLikeFavouriteEquipmentItem({
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
