import 'package:api/api_client/index.dart';
import 'package:api/booking/request/new_booking_review_request.dart';
import 'package:domain/models/models.dart';
import 'package:api/api_client/response_type/response_type.dart';

class NewBookingReviewService {
  final APIClient resApiClient;
  NewBookingReviewService({
    required this.resApiClient,
  });
  Future<ObjectResponse<NewBookingModel>> addNewBooking({
    required String orderableType,
    required int orderableId,
    required DateTime startDate,
    required double startTime,
    required DateTime endDate,
    required double endTime,
  }) async {
    final request = NewBookingReviewRequest.addNewBooking(
      orderableType: orderableType,
      orderableId: orderableId,
      startDate: startDate,
      startTime: startTime,
      endDate: endDate,
      endTime: endTime,
    );
    final response = await resApiClient.execute(request: request);
    final object = NewBookingModel.fromJson(response.data);
    return ObjectResponse(object: object);
  }
}
