import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_ui/shared_ui.dart';

import '../new_booking_review/new_booking_review_screen.dart';
import 'bloc/new_booking_select_time_bloc.dart';
import 'view/info_booking_view.dart';

class NewBookingSelectTimeScreen extends StatefulWidget {
  const NewBookingSelectTimeScreen({
    this.equipmentItem,
    this.meetingRoomItem,
    Key? key,
  }) : super(key: key);
  // final String nameBooking;
  final EquipmentItem? equipmentItem;
  final MeetingRoomItem? meetingRoomItem;

  @override
  State<NewBookingSelectTimeScreen> createState() => _NewBookingSelectTimeScreenState();
}

class _NewBookingSelectTimeScreenState extends State<NewBookingSelectTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewBookingSelectTimeBloc()
        ..add(
          FetchDateEvent(
            dateTime: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              12,
              0,
            ),
          ),
        ),
      child: BlocBuilder<NewBookingSelectTimeBloc, NewBookingSelectTimeState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<NewBookingSelectTimeBloc>(context);
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  backgroundColor: primaryColor,
                  title: Text(
                    (widget.equipmentItem?.name ?? widget.meetingRoomItem?.name) ?? '',
                    style: titleAppBarTextStyle,
                  ),
                  elevation: 1,
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: blackColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: GestureDetector(
                        onTap: () {
                          bloc.add(ToggleDetailsEvent());
                        },
                        child: Image(
                          image: AssetImage(ImagePath.infoIconOutline.assetName),
                          height: 20,
                          width: 20,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Container(
                        color: greenColor.withOpacity(0.3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                bloc.add(PreviousDateEvent());
                              },
                              child: const Icon(
                                size: 15,
                                Icons.arrow_back_ios_new_rounded,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDatePicker(
                                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.teal,
                                        primaryColorDark: greenColor,
                                      ),
                                      child: child ?? const SizedBox(),
                                    );
                                  },
                                  context: context,
                                  initialDate: state.dateTime,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2025),
                                ).then((value) {
                                  setState(() {
                                    state.dateTime = value ?? state.dateTime;
                                  });
                                  return state.dateTime;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                                child: Text(
                                  DateFormat('EEE, dd MMM yyyy').format(state.dateTime),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                bloc.add(NextDateEvent());
                              },
                              child: const Icon(
                                size: 15,
                                Icons.arrow_forward_ios_rounded,
                              ),
                            )
                          ],
                        )),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemBuilder: itemBuilder,
                        separatorBuilder: separatorBuilder,
                        itemCount: state.listTime.length,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: bloc.isOpen,
                child: InfoBookingView(
                  equipmentItem: widget.equipmentItem,
                  meetingRoomItem: widget.meetingRoomItem,
                ),
              ),
            ],
          );
        },
      ),
    );
    // );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var bloc = BlocProvider.of<NewBookingSelectTimeBloc>(context);
    var timeItem = bloc.state.listTime[index];
    return GestureDetector(
      onTapDown: (details) {
        if (details.localPosition.dy >= 0 && details.localPosition.dy <= 18) {
          goToNewBookingReviewScreen(fromDate: bloc.state.dateTime, fromTime: timeItem);
        } else if (details.localPosition.dy > 18 && details.localPosition.dy <= 36) {
          goToNewBookingReviewScreen(
              fromDate: bloc.state.dateTime, fromTime: timeItem.add(const Duration(minutes: 15)));
        } else if (details.localPosition.dy > 36 && details.localPosition.dy <= 54) {
          goToNewBookingReviewScreen(
              fromDate: bloc.state.dateTime, fromTime: timeItem.add(const Duration(minutes: 30)));
        } else {
          goToNewBookingReviewScreen(
              fromDate: bloc.state.dateTime, fromTime: timeItem.add(const Duration(minutes: 45)));
        }
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
        ),
        width: 366,
        height: 72,
        decoration: BoxDecoration(
          color: greyColor.withOpacity(0.15),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            DateFormat('hh:mm a').format(timeItem),
            style: timeTextStyle,
          ),
        ),
      ),
    );
  }

  void goToNewBookingReviewScreen({required DateTime fromDate, required DateTime fromTime}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewBookingReviewScreen(
          equipmentItem: widget.equipmentItem,
          meetingRoomItem: widget.meetingRoomItem,
          fromDate: fromDate,
          fromTime: fromTime,
        ),
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        color: greyColor.withOpacity(0.3),
      ),
    );
  }
}
