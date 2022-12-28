import 'package:api/api_client/response_type/response_type.dart';
import 'package:api/meeting_room/request/meeting_room_request.dart';
import 'package:domain/models/meeting_rooms/new_meeting_room_items_toggle_like_model.dart';
import 'package:domain/models/meeting_rooms/new_meeting_room_model.dart';

import '../../api_client/api_client.dart';

class MeeingRoomService {
  final APIClient restAPIClient;
  MeeingRoomService({
    required this.restAPIClient,
  });

  Future<ListResponse<MeetingRoomItem>> getNewBookingMeetingRooms({
    int? page,
    int? perPage,
    List<int>? sites,
    String? keywords,
  }) async {
    {
      final request = MeetingRoomRequest.getNewBookingMeetingRooms(
        page: page,
        perPage: perPage,
        sites: sites,
        keywords: keywords,
      );
      final response = await restAPIClient.execute(request: request);
      final listResponse =
          response.toList().map<MeetingRoomItem>((e) => MeetingRoomItem.fromJson(e)).toList();
      return ListResponse(list: listResponse);
    }
  }

  Future<ObjectResponse<MeetingRoomItemToggleLike>> toggleLikeNewBookingMeetingRoomsItem({
    required int id,
  }) async {
    final request = MeetingRoomRequest.toggleLikeNewBookingMeetingRoomsItem(id: id);
    final response = await restAPIClient.execute(request: request);
    final objectResponse = MeetingRoomItemToggleLike.fromJson(response.data);
    return ObjectResponse(object: objectResponse);
  }
}
