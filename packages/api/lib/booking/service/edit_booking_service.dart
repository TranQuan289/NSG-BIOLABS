import 'package:api/api_client/index.dart';
import 'package:api/api_client/response_type/response_type.dart';
import 'package:api/booking/request/edit_booking_request.dart';
import 'package:domain/models/models.dart';

class EditBookingService {
  final APIClient restApiClient;
  EditBookingService({required this.restApiClient});
  Future<ObjectResponse<DeleteBookingModel>> deleteBooking({
    required int id,
  }) async {
    final request = EditBookingRequest.deleteBooking(id: id);
    final response = await restApiClient.execute(request: request);
    final object = DeleteBookingModel.fromJson(response.data);
    return ObjectResponse(object: object);
  }

  Future<ObjectResponse<UpdateBookingModel>> updateBooking({
    required int id,
    DateTime? startDate,
    double? startTime,
    DateTime? endDate,
    double? endTime,
  }) async {
    final request = EditBookingRequest.updateBooking(
      id: id,
      startDate: startDate,
      startTime: startTime,
      endDate: endDate,
      endTime: endTime,
    );
    final response = await restApiClient.execute(request: request);
    final object = UpdateBookingModel.fromJson(response.data);
    return ObjectResponse(object: object);
  }
}
