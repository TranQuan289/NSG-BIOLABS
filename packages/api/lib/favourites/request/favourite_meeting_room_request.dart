import 'package:api/api_client/index.dart';

class FavouriteMeetingRoomRequest {
  FavouriteMeetingRoomRequest._();
  static APIRequest getFavouriteMeetingRooms({
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

  static APIRequest toggleLikeFavouriteMeetingRoomsItem({
    required int id,
  }) {
    return APIRequest(
      method: HTTPMethods.post,
      path: '/meeting_rooms/$id/toggle_like',
      parameters: {
        'id': id,
      },
    );
  }
}
