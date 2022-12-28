import 'package:api/api.dart';
import 'package:dio/dio.dart';

class EditBookingRequest {
  EditBookingRequest._();
  static APIRequest deleteBooking({
    required int id,
  }) {
    return APIRequest(
      method: HTTPMethods.delete,
      path: '/bookings/$id',
    );
  }

  static APIRequest updateBooking({
    required int id,
    DateTime? startDate,
    double? startTime,
    DateTime? endDate,
    double? endTime,
  }) {
    return APIRequest(
      method: HTTPMethods.put,
      path: '/bookings/$id',
      parameters: {
        'id': id,
      },
      body: FormData.fromMap(
        {
          'start_date': startDate,
          'start_time': startTime,
          'end_date': endDate,
          'end_time': endTime,
        },
      ),
    );
  }
}
