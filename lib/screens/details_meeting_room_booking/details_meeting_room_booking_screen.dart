import 'package:domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/colors/index.dart';
import 'package:shared_ui/styles/index.dart';

import '../../utilities/index.dart';
import '../edit_booking/edit_booking_screen.dart';
import 'bloc/details_meeting_room_booking_bloc.dart';
import 'widgets/text_widget_meeting_room_details.dart';

class DetailsMeetingRoomBookingScreen extends StatefulWidget {
  const DetailsMeetingRoomBookingScreen({
    super.key,
    this.ongoingBooking,
    this.upcomingBooking,
    required this.checkBooking,
  });
  final OngoingBooking? ongoingBooking;
  final UpcomingBooking? upcomingBooking;
  final bool checkBooking;
  @override
  State<DetailsMeetingRoomBookingScreen> createState() => _DetailsMeetingRoomBookingScreenState();
}

class _DetailsMeetingRoomBookingScreenState extends State<DetailsMeetingRoomBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsMeetingRoomBookingBloc()
        ..add(FetchDataDetailsMeetingRoomEvent(
          ongoingBookingMeetingRoom: widget.ongoingBooking,
          upcomingBookingMeetingRoom: widget.upcomingBooking,
        )),
      child: BlocConsumer<DetailsMeetingRoomBookingBloc, DetailsMeetingRoomBookingState>(
        buildWhen: (previous, current) {
          if (current is DetailsMeetingRoomBookingSuccess) {
            return true;
          } else {
            return false;
          }
        },
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DetailsMeetingRoomBookingSuccess) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditBookingScreen(
                            ongoingBooking: state.ongoingBookingMeetingRoom,
                            upcomingBooking: state.upcomingBookingMeetingRoom,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Icon(
                        Icons.edit,
                        color: greenColor,
                        size: 25,
                      ),
                    ),
                  )
                ],
                elevation: 1,
                centerTitle: true,
                title: Text(
                  'View Booking',
                  style: titleAppBarTextStyle,
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidgetMeetingRoomDetails(
                        data: 'Room Name',
                        textStyle: titleDetailsTextStyle,
                      ),
                      const SizedBox(height: 1),
                      TextWidgetMeetingRoomDetails(
                        data: checkMeetingRoomName(
                          widget.checkBooking
                              ? state.ongoingBookingMeetingRoom
                              : state.upcomingBookingMeetingRoom,
                        ),
                        textStyle: contentDetailsTextStyle,
                      ),
                      const SizedBox(height: 19),
                      TextWidgetMeetingRoomDetails(
                        data: 'Location',
                        textStyle: titleDetailsTextStyle,
                      ),
                      const SizedBox(height: 1),
                      TextWidgetMeetingRoomDetails(
                        data: checkMeetingRoomLevelAndSiteName(
                          widget.checkBooking
                              ? state.ongoingBookingMeetingRoom
                              : state.upcomingBookingMeetingRoom,
                        ),
                        textStyle: contentDetailsTextStyle,
                      ),
                      const SizedBox(height: 19),
                      TextWidgetMeetingRoomDetails(
                          data: 'Datetime', textStyle: titleDetailsTextStyle),
                      const SizedBox(height: 1),
                      TextWidgetMeetingRoomDetails(
                        data: checkMeetingRoomDateTime(
                          widget.checkBooking
                              ? state.ongoingBookingMeetingRoom
                              : state.upcomingBookingMeetingRoom,
                        ),
                        textStyle: contentDetailsTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  String checkMeetingRoomName(Object? booking) {
    if (booking is OngoingBooking) {
      return booking.orderable?.name ?? '';
    } else if (booking is UpcomingBooking) {
      return booking.orderable?.name ?? '';
    } else {
      return '';
    }
  }

  String checkMeetingRoomLevelAndSiteName(Object? booking) {
    if (booking is OngoingBooking) {
      return 'Level ${booking.orderable?.site?.level}, ${booking.orderable?.site?.name}';
    } else if (booking is UpcomingBooking) {
      return 'Level ${booking.orderable?.site?.level}, ${booking.orderable?.site?.name}';
    } else {
      return '';
    }
  }

  String checkMeetingRoomDateTime(Object? booking) {
    if (booking is OngoingBooking) {
      var ongoingBookingStartDate = Utilities().dateFormat(booking.startDate ?? DateTime.now(),'MMM d (EEE)');
      var ongoingBookingStartTime =
          Utilities().timeFormat(Utilities().convertDoubleToTime(booking.startTime ?? 0));
      var ongoingBookingEndTime =
          Utilities().timeFormat(Utilities().convertDoubleToTime(booking.endTime ?? 0));
      return '$ongoingBookingStartDate $ongoingBookingStartTime - $ongoingBookingEndTime';
    } else if (booking is UpcomingBooking) {
      var upcomingBookingStartDate = Utilities().dateFormat(booking.startDate ?? DateTime.now(),'MMM d (EEE)');
      var upcomingBookingStartTime =
          Utilities().timeFormat(Utilities().convertDoubleToTime(booking.startTime ?? 0));
      var upcomingBookingEndTime =
          Utilities().timeFormat(Utilities().convertDoubleToTime(booking.endTime ?? 0));
      return '$upcomingBookingStartDate $upcomingBookingStartTime - $upcomingBookingEndTime';
    } else {
      return '';
    }
  }
}
