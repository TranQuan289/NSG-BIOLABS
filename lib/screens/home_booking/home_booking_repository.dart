import 'package:api/api_client/response_type/response_type.dart';
import 'package:api/booking/service/home_booking_service.dart';
import 'package:domain/models/bookings/ongoing_booking_model.dart';
import 'package:domain/models/bookings/upcoming_booking_model.dart';

import '../../utilities/rest_api_client/api_client.dart';

class HomeBookingRepository {
  final RestAPIClient restApiClient;
  HomeBookingRepository({
    required this.restApiClient,
  });
  Future<ListResponse<UpcomingBooking>> getUpcomingBookings({
    int? page,
    int? perPage,
  }) async {
    return HomeBookingService(resApiClient: restApiClient).getUpcomingBookings(
      page: page,
      perPage: perPage,
    );
  }

  Future<ListResponse<OngoingBooking>> getOngoingBookings() async {
    return HomeBookingService(resApiClient: restApiClient).getOngoingBookings();
  }
}
