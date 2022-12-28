import 'package:api/api.dart';
import 'package:api/api_client/response_type/response_type.dart';
import 'package:api/favourites/request/favourite_meeting_room_request.dart';
import 'package:domain/models/models.dart';

class FavouriteMeetingRoomService {
  final APIClient restAPIClient;
  FavouriteMeetingRoomService({
    required this.restAPIClient,
  });
  Future<ListResponse<MeetingRoomItem>> getFavouriteMeetingRooms({
    int? page,
    int? perPage,
    required String dataMode,
  }) async {
    {
      final request = FavouriteMeetingRoomRequest.getFavouriteMeetingRooms(
        page: page,
        perPage: perPage,
        dataMode: dataMode,
      );
      final response = await restAPIClient.execute(request: request);
      final listResponse = response
          .toList()
          .map<FavouriteMeetingRoomModel>((e) => FavouriteMeetingRoomModel.fromJson(e))
          .toList();
      return ListResponse(list: convertToListEquipment(listResponse));
    }
  }

  Future<ObjectResponse<MeetingRoomItemToggleLike>> toggleLikeFavouriteMeetingRoomsItem({
    required int id,
  }) async {
    final request = FavouriteMeetingRoomRequest.toggleLikeFavouriteMeetingRoomsItem(id: id);
    final response = await restAPIClient.execute(request: request);
    final objectResponse = MeetingRoomItemToggleLike.fromJson(response.data);
    return ObjectResponse(object: objectResponse);
  }

  List<MeetingRoomItem> convertToListEquipment(List<FavouriteMeetingRoomModel> listEquipment) {
    List<MeetingRoomItem> result = [];
    for (var i in listEquipment) {
      if (i.orderable != null) {
        result.add(i.orderable!);
      }
    }
    return result;
  }
}
