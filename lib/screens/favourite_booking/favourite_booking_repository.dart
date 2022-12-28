import 'package:api/api_client/response_type/response_type.dart';
import 'package:api/favourites/service/favourite_equipment_service.dart';
import 'package:api/favourites/service/favourite_meeting_room_service.dart';
import 'package:domain/models/models.dart';

import '../../utilities/rest_api_client/api_client.dart';

class FavouriteBookingRepository {
  final RestAPIClient restApiClient;
  FavouriteBookingRepository({
    required this.restApiClient,
  });
  Future<ListResponse<EquipmentItem>> getFavouriteEquipmentItems({
    int? page,
    int? perPage,
    required String dataMode,
  }) async {
    return FavouriteEquipmentService(restAPIClient: restApiClient).getFavouriteEquipmentItems(
      page: page,
      perPage: perPage,
      dataMode: dataMode,
    );
  }

  Future<ObjectResponse<EquipmentItemToggleLike>> toggleLikeFavouriteEquipmentItem({
    required int id,
  }) async {
    return FavouriteEquipmentService(restAPIClient: restApiClient).toggleLikeFavouriteEquipmentItem(
      id: id,
    );
  }

  Future<ListResponse<MeetingRoomItem>> getFavouriteMeetingRooms({
    int? page,
    int? perPage,
    required String dataMode,
  }) async {
    return FavouriteMeetingRoomService(restAPIClient: restApiClient).getFavouriteMeetingRooms(
      page: page,
      perPage: perPage,
      dataMode: dataMode,
    );
  }

  Future<ObjectResponse<MeetingRoomItemToggleLike>> toggleLikeFavouriteMeetingRoomsItem({
    required int id,
  }) {
    return FavouriteMeetingRoomService(restAPIClient: restApiClient)
        .toggleLikeFavouriteMeetingRoomsItem(
      id: id,
    );
  }
}
