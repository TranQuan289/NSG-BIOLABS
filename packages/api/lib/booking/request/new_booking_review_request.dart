import 'package:api/api.dart';
import 'package:dio/dio.dart';

class NewBookingReviewRequest {
  NewBookingReviewRequest._();
  static APIRequest addNewBooking({
    required String orderableType,
    required int orderableId,
    required DateTime startDate,
    required double startTime,
    required DateTime endDate,
    required double endTime,
  }) {
    return APIRequest(
      method: HTTPMethods.post,
      path: '/bookings',
      body: FormData.fromMap(
        {
          'orderable_type': orderableType,
          'orderable_id': orderableId,
          'start_date': startDate,
          'start_time': startTime,
          'end_date': endDate,
          'end_time': endTime,
        },
      ),
    );
  }
}
