import 'package:api/api_client/response_type/response_type.dart';
import 'package:domain/models/models.dart';
import 'package:api/booking/service/new_booking_review_service.dart';
import '../../utilities/rest_api_client/index.dart';

class NewBookingReviewRepository {
  final RestAPIClient restApiClient;
  NewBookingReviewRepository({
    required this.restApiClient,
  });
  Future<ObjectResponse<NewBookingModel>> addNewBooking({
    required String orderableType,
    required int orderableId,
    required DateTime startDate,
    required double startTime,
    required DateTime endDate,
    required double endTime,
  }) {
    return NewBookingReviewService(resApiClient: restApiClient).addNewBooking(
      orderableType: orderableType,
      orderableId: orderableId,
      startDate: startDate,
      startTime: startTime,
      endDate: endDate,
      endTime: endTime,
    );
  }
}
