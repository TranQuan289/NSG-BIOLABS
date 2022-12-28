import 'package:api/api_client/index.dart';
import 'package:api/api_client/response_type/response_type.dart';
import 'package:api/booking/request/new_booking_select_time_request.dart';
import 'package:domain/models/models.dart';

class NewBookingSelectTimeService {
  final APIClient restAPIClient;
  NewBookingSelectTimeService({
    required this.restAPIClient,
  });

  Future<ObjectResponse<EquipmentItemToggleLike>> toggleLikeInfoEquipmentItem({
    required int id,
  }) async {
    final request = NewBookingSelectTimeRequest.toggleLikeInfoEquipmentItem(id: id);
    final response = await restAPIClient.execute(request: request);
    final objectResponse = EquipmentItemToggleLike.fromJson(response.data);
    return ObjectResponse(object: objectResponse);
  }

  Future<ObjectResponse<MeetingRoomItemToggleLike>> toggleLikeInfoMeetingRoomsItem({
    required int id,
  }) async {
    final request = NewBookingSelectTimeRequest.toggleLikeInfoMeetingRoomsItem(id: id);
    final response = await restAPIClient.execute(request: request);
    final objectResponse = MeetingRoomItemToggleLike.fromJson(response.data);
    return ObjectResponse(object: objectResponse);
  }
}
