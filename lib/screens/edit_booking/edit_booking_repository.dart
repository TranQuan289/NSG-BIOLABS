import 'package:api/api_client/response_type/response_type.dart';
import 'package:api/booking/service/edit_booking_service.dart';
import 'package:domain/models/models.dart';

import '../../utilities/rest_api_client/index.dart';

class EditBookingRepository {
  final RestAPIClient restApiClient;
  EditBookingRepository({
    required this.restApiClient,
  });

  Future<ObjectResponse<DeleteBookingModel>> deleteBooking({
    required int id,
  }) async {
    return EditBookingService(restApiClient: restApiClient).deleteBooking(
      id: id,
    );
  }

  Future<ObjectResponse<UpdateBookingModel>> updateBooking({
    required int id,
    DateTime? startDate,
    double? startTime,
    DateTime? endDate,
    double? endTime,
  }) async {
    return EditBookingService(restApiClient: restApiClient).updateBooking(
      id: id,
      startDate: startDate,
      startTime: startTime,
      endDate: endDate,
      endTime: endTime,
    );
  }
}
