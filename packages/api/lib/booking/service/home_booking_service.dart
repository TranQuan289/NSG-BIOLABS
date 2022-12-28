import 'package:domain/models/bookings/ongoing_booking_model.dart';
import 'package:domain/models/bookings/upcoming_booking_model.dart';
import '../../api_client/api_client.dart';
import '../../api_client/response_type/response_type.dart';
import '../request/home_booking_request.dart';

class HomeBookingService {
  final APIClient resApiClient;
  HomeBookingService({required this.resApiClient});
  Future<ListResponse<UpcomingBooking>> getUpcomingBookings({
    int? page,
    int? perPage,
  }) async {
    final request = HomeBookingRequest.getUpcomingBookings(
      page: page,
      perPage: perPage,
    );
    final response = await resApiClient.execute(request: request);
    final listResponse =
        response.toList().map<UpcomingBooking>((e) => UpcomingBooking.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<OngoingBooking>> getOngoingBookings() async {
    final request = HomeBookingRequest.getOngoingBookings();
    final response = await resApiClient.execute(request: request);
    final listResponse =
        response.toList().map<OngoingBooking>((e) => OngoingBooking.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}
