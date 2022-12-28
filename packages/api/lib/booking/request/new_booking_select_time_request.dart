import 'package:api/api_client/index.dart';

class NewBookingSelectTimeRequest {
  NewBookingSelectTimeRequest._();
  static APIRequest toggleLikeInfoEquipmentItem({
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

  static APIRequest toggleLikeInfoMeetingRoomsItem({
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
