import 'package:api/api_client/response_type/response_type.dart';
import 'package:api/equipment_items/service/equipment_items_service.dart';
import 'package:api/meeting_room/service/meeting_room_service.dart';
import 'package:domain/models/equipment_items/new_equipment_items_model.dart';
import 'package:domain/models/equipment_items/new_equipment_items_toggle_like_model.dart';
import 'package:domain/models/meeting_rooms/new_meeting_room_items_toggle_like_model.dart';
import 'package:domain/models/meeting_rooms/new_meeting_room_model.dart';

import '../../utilities/rest_api_client/api_client.dart';

class NewBookingRepository {
  final RestAPIClient restApiClient;
  NewBookingRepository({
    required this.restApiClient,
  });
  Future<ListResponse<EquipmentItem>> getNewBookingEquipmentItems({
    int? page,
    int? perPage,
    List<int>? levels,
    List<int>? sites,
    List<int>? types,
    String? keywords,
  }) async {
    return EquipmentService(restAPIClient: restApiClient).getNewBookingEquipmentItems(
      page: page,
      perPage: perPage,
      levels: levels,
      sites: sites,
      types: types,
      keywords: keywords,
    );
  }

  Future<ObjectResponse<EquipmentItemToggleLike>> toggleLikeNewBookingEquipmentItem({
    required int id,
  }) async {
    return EquipmentService(restAPIClient: restApiClient).toggleLikeNewBookingEquipmentItem(
      id: id,
    );
  }

  Future<ListResponse<MeetingRoomItem>> getNewBookingMeetingRooms({
    int? page,
    int? perPage,
    List<int>? sites,
    String? keywords,
  }) async {
    return MeeingRoomService(restAPIClient: restApiClient).getNewBookingMeetingRooms(
      page: page,
      perPage: perPage,
      sites: sites,
      keywords: keywords,
    );
  }

  Future<ObjectResponse<MeetingRoomItemToggleLike>> toggleLikeNewBookingMeetingRoomsItem({
    required int id,
  }) {
    return MeeingRoomService(restAPIClient: restApiClient).toggleLikeNewBookingMeetingRoomsItem(
      id: id,
    );
  }
}
