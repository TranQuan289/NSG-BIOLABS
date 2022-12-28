import 'package:api/api.dart';

class HomeBookingRequest {
  HomeBookingRequest._();

  static APIRequest getUpcomingBookings({
    int? page,
    int? perPage,
  }) {
    return APIRequest(
      method: HTTPMethods.get,
      path: '/bookings/my_upcoming',
      parameters: {
        'page': page,
        'per_page': perPage,
      },
    );
  }

  static APIRequest getOngoingBookings() {
    return APIRequest(
      method: HTTPMethods.get,
      path: '/bookings/my_ongoing',
    );
  }
}
