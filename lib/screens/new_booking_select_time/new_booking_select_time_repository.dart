import 'package:api/api_client/response_type/response_type.dart';
import 'package:domain/models/models.dart';
import 'package:api/booking/service/new_booking_select_time_service.dart';
import '../../utilities/rest_api_client/index.dart';

class NewBookingSelectTimeRepository {
  final RestAPIClient restApiClient;
  NewBookingSelectTimeRepository({
    required this.restApiClient,
  });

  Future<ObjectResponse<EquipmentItemToggleLike>> toggleLikeInfoEquipmentItem({
    required int id,
  }) async {
    return NewBookingSelectTimeService(restAPIClient: restApiClient).toggleLikeInfoEquipmentItem(
      id: id,
    );
  }

  Future<ObjectResponse<MeetingRoomItemToggleLike>> toggleLikeInfoMeetingRoomsItem({
    required int id,
  }) {
    return NewBookingSelectTimeService(restAPIClient: restApiClient).toggleLikeInfoMeetingRoomsItem(
      id: id,
    );
  }
}
