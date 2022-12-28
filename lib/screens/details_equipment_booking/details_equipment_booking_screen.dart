import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/colors/index.dart';
import 'package:shared_ui/styles/index.dart';

import '../../utilities/index.dart';
import '../edit_booking/edit_booking_screen.dart';
import 'bloc/details_equipment_booking_bloc.dart';
import 'widgets/text_widget_equipment_details.dart';

class DetailsEquipmentBookingScreen extends StatefulWidget {
  const DetailsEquipmentBookingScreen({
    super.key,
    this.ongoingBooking,
    this.upcomingBooking,
    required this.checkBooking,
  });
  final OngoingBooking? ongoingBooking;
  final UpcomingBooking? upcomingBooking;
  final bool checkBooking;

  @override
  State<DetailsEquipmentBookingScreen> createState() => _DetailsEquipmentBookingScreenState();
}

class _DetailsEquipmentBookingScreenState extends State<DetailsEquipmentBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsEquipmentBookingBloc()
        ..add(FetchDataDetailsEquipmentEvent(
          ongoingBookingEquipment: widget.ongoingBooking,
          upcomingBookingEquipment: widget.upcomingBooking,
        )),
      child: BlocConsumer<DetailsEquipmentBookingBloc, DetailsEquipmentBookingState>(
        buildWhen: (previous, current) {
          if (current is DetailsEquipmentBookingSuccess) {
            return true;
          } else {
            return false;
          }
        },
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DetailsEquipmentBookingSuccess) {
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
                            ongoingBooking: state.ongoingBookingEquipment,
                            upcomingBooking: state.upcomingBookingEquipment,
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
                      TextWidgetEquipmentDetails(
                        data: 'Equipment Name',
                        textStyle: titleDetailsTextStyle,
                      ),
                      const SizedBox(height: 1),
                      TextWidgetEquipmentDetails(
                        data: checkEquipmentName(
                          widget.checkBooking
                              ? state.ongoingBookingEquipment
                              : state.upcomingBookingEquipment,
                        ),
                        textStyle: contentDetailsTextStyle,
                      ),
                      const SizedBox(height: 19),
                      TextWidgetEquipmentDetails(
                          data: 'Equipment ID', textStyle: titleDetailsTextStyle),
                      const SizedBox(height: 1),
                      TextWidgetEquipmentDetails(
                        data: checkEquipmentId(
                          widget.checkBooking
                              ? state.ongoingBookingEquipment
                              : state.upcomingBookingEquipment,
                        ),
                        textStyle: contentDetailsTextStyle,
                      ),
                      const SizedBox(height: 19),
                      TextWidgetEquipmentDetails(
                          data: 'Location', textStyle: titleDetailsTextStyle),
                      const SizedBox(height: 1),
                      TextWidgetEquipmentDetails(
                        data: checkEquipmentLevelAndSiteName(
                          widget.checkBooking
                              ? state.ongoingBookingEquipment
                              : state.upcomingBookingEquipment,
                        ),
                        textStyle: contentDetailsTextStyle,
                      ),
                      const SizedBox(height: 19),
                      TextWidgetEquipmentDetails(
                          data: 'Datetime', textStyle: titleDetailsTextStyle),
                      const SizedBox(height: 1),
                      TextWidgetEquipmentDetails(
                        data: checkEquipmentDateTime(
                          widget.checkBooking
                              ? state.ongoingBookingEquipment
                              : state.upcomingBookingEquipment,
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

  String checkEquipmentName(Object? booking) {
    if (booking is OngoingBooking) {
      return booking.orderable?.name ?? '';
    } else if (booking is UpcomingBooking) {
      return booking.orderable?.name ?? '';
    } else {
      return '';
    }
  }

  String checkEquipmentId(Object? booking) {
    if (booking is OngoingBooking) {
      return 'NSG-00${booking.orderable?.id}';
    } else if (booking is UpcomingBooking) {
      return 'NSG-00${booking.orderable?.id}';
    } else {
      return '';
    }
  }

  String checkEquipmentLevelAndSiteName(Object? booking) {
    if (booking is OngoingBooking) {
      return 'Level ${booking.orderable?.site?.level}, ${booking.orderable?.site?.name}';
    } else if (booking is UpcomingBooking) {
      return 'Level ${booking.orderable?.site?.level}, ${booking.orderable?.site?.name}';
    } else {
      return '';
    }
  }

  String checkEquipmentDateTime(Object? booking) {
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
