import 'package:dio/dio.dart';

import '../../api_client/index.dart';

class MeetingRoomRequest {
  MeetingRoomRequest._();
  static APIRequest getNewBookingMeetingRooms({
    int? page,
    int? perPage,
    List<int>? sites,
    String? keywords,
  }) {
    return APIRequest(
      method: HTTPMethods.get,
      path: '/meeting_rooms',
      parameters: {
        'page': page,
        'per_page': perPage,
        'keywords': keywords,
      },
      body: FormData.fromMap({
        'sites': sites,
      }),
    );
  }
  static APIRequest toggleLikeNewBookingMeetingRoomsItem({
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
