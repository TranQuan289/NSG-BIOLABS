import 'dart:async';

import 'package:codebase/blocs/bloc/global_bloc.dart';
import 'package:codebase/screens/edit_booking/edit_booking_repository.dart';
import 'package:codebase/utilities/index.dart';
import 'package:codebase/utilities/rest_api_client/api_client.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import 'bloc/edit_booking_bloc.dart';
import 'widgets/index.dart';

class EditBookingScreen extends StatefulWidget {
  const EditBookingScreen({
    super.key,
    this.ongoingBooking,
    this.upcomingBooking,
  });
  final OngoingBooking? ongoingBooking;
  final UpcomingBooking? upcomingBooking;
  @override
  State<EditBookingScreen> createState() => _EditBookingScreenState();
}

class _EditBookingScreenState extends State<EditBookingScreen> {
  late DateTime fromDate = getFromDate();
  late DateTime toDate = getToDate();
  late DateTime fromTime = getFromTime();
  late DateTime toTime = getToTime();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditBookingBloc(EditBookingRepository(
        restApiClient: RestAPIClient(),
      ))
        ..add(
          FetchDataEditBookingEvent(
            ongoingBooking: widget.ongoingBooking,
            upcomingBooking: widget.upcomingBooking,
          ),
        ),
      child: BlocConsumer<EditBookingBloc, EditBookingState>(
        buildWhen: (previous, current) {
          if (current is EditBookingInitial) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          if (state is EditBookingDeleteSuccess) {
            BlocProvider.of<GlobalBloc>(context)
                .add(GlobalDeleteUpcomingBooking(upcomingBooking: state.upcomingBooking!));
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (state is EditBookingUpdateSuccess) {
            if (state.ongoingBooking != null) {
              BlocProvider.of<GlobalBloc>(context)
                  .add(GlobalUpdateBooking(ongoingBooking: state.ongoingBooking));
            } else {
              BlocProvider.of<GlobalBloc>(context)
                  .add(GlobalUpdateBooking(upcomingBooking: state.upcomingBooking));
            }

            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context).pop();
            });
          } else if (state is EditBookingUpdateError) {
            Future.delayed(
              const Duration(milliseconds: 500),
            ).then(
              (value) => showDialogError(context, state.errorMessage),
            );
          }
        },
        builder: (context, state) {
          var bloc = BlocProvider.of<EditBookingBloc>(context);
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
              elevation: 1,
              centerTitle: true,
              title: Text(
                'Edit Booking',
                style: titleAppBarTextStyle,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 31),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidgetEditBooking(
                      data: 'Equipment',
                      textStyle: titleEditBookingTextStyle,
                    ),
                    const SizedBox(height: 7),
                    Container(
                      width: 369,
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(21, 0, 21, 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: superLightGreyColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                        border: Border.all(
                          width: 1,
                          color: lightGreyColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Align(
                        child: TextWidgetEditBooking(
                          data: getDetailsBooking(context),
                          maxLinesText: 1,
                          softWrap: false,
                          textOverflow: TextOverflow.clip,
                          textStyle: contentEditBookingTextStyle(blackColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextWidgetEditBooking(
                      data: 'From',
                      textStyle: titleEditBookingTextStyle,
                    ),
                    const SizedBox(height: 7),
                    TextFieldDateTimeEditBooking(
                      childIcon: Utilities().checkDateTime(fromDate, toDate, fromTime, toTime)
                          ? Icon(Icons.check_circle_sharp, color: greenColor)
                          : alertIcon(),
                      hasBackGroundColor: false,
                      // backGroundColor: superLightGreyColor,
                      onTapDate: () async {
                        await showFromDatePicker(context: context);
                      },
                      onTapTime: () async {
                        await showFromTimePicker(context: context);
                      },
                      childTextDate: TextWidgetEditBooking(
                        data: Utilities().dateFormat(fromDate, 'dd MMM yyyy'),
                        textStyle: contentEditBookingTextStyle(blackColor),
                      ),
                      childTextTime: TextWidgetEditBooking(
                        data: Utilities().timeFormat(fromTime),
                        textStyle: contentEditBookingTextStyle(
                          Utilities().checkDateTime(fromDate, toDate, fromTime, toTime)
                              ? blackColor
                              : redColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextWidgetEditBooking(
                      data: 'To',
                      textStyle: titleEditBookingTextStyle,
                    ),
                    TextFieldDateTimeEditBooking(
                      childIcon: Utilities().checkDateTime(fromDate, toDate, fromTime, toTime)
                          ? Icon(Icons.check_circle_sharp, color: greenColor)
                          : alertIcon(),
                      onTapDate: () async {
                        await showToDatePicker(context: context);
                      },
                      onTapTime: () async {
                        await showToTimePicker(context: context);
                      },
                      childTextDate: TextWidgetEditBooking(
                        data: Utilities().dateFormat(toDate, 'dd MMM yyyy'),
                        textStyle: contentEditBookingTextStyle(blackColor),
                      ),
                      childTextTime: TextWidgetEditBooking(
                        data: Utilities().timeFormat(toTime),
                        textStyle: contentEditBookingTextStyle(
                          Utilities().checkDateTime(fromDate, toDate, fromTime, toTime)
                              ? blackColor
                              : redColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: TextWidgetEditBooking(
                          data: 'Check Availability on Timeline',
                          textStyle: checkTimelineEditBookingTextStyle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 369,
                      height: 48,
                      child: ConfirmButton(
                        style: Utilities().checkDateTime(fromDate, toDate, fromTime, toTime)
                            ? greenButtonStyle
                            : disableButtonStyle,
                        onPress: Utilities().checkDateTime(fromDate, toDate, fromTime, toTime)
                            ? () {
                                showProgressIndicator(context);
                                bloc.add(
                                  UpdateBookingEvent(
                                    id: getIdBooking(context),
                                    fromDate: Utilities().convertDate(fromDate),
                                    toDate: Utilities().convertDate(toDate),
                                    fromTime: Utilities().convertTimeToDouble(fromTime),
                                    toTime: Utilities().convertTimeToDouble(toTime),
                                  ),
                                );
                              }
                            : null,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 369,
                      height: 48,
                      child: CancelBookingButton(
                        textCancel: getCancelText(context),
                        onPress: () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return CustomDialog(
                                height: 300,
                                visibleBackButton: true,
                                visibleConfirmButton: true,
                                stringBackButton: 'Back',
                                stringConfirmButton: 'COMFIRM',
                                askingString: getStringAsking(context),
                                undoString: 'You will not be able to undo.',
                                visibleDialogMessage: true,
                                visibleErrorMessage: false,
                                colorConfirmButton: redColor,
                                onTapBackButton: () => Navigator.pop(dialogContext),
                                onTapConfirmButton: () {
                                  bloc.add(DeleteBookingEvent(
                                    id: getIdBooking(context),
                                  ));
                                  Navigator.pop(dialogContext);
                                  showProgressIndicatorDeleting(context);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String getStringAsking(BuildContext context) {
    var state = BlocProvider.of<EditBookingBloc>(context).state;
    if (state.ongoingBooking != null) {
      return 'End this booking early?';
    } else {
      return 'Cancel this booking?';
    }
  }

  String getDetailsBooking(BuildContext context) {
    var state = BlocProvider.of<EditBookingBloc>(context).state;
    if (state.ongoingBooking != null) {
      return '${state.ongoingBooking?.orderable?.name} - Level ${state.ongoingBooking?.orderable?.site?.level}, ${state.ongoingBooking?.orderable?.site?.name}';
    } else {
      return '${state.upcomingBooking?.orderable?.name} - Level ${state.upcomingBooking?.orderable?.site?.level}, ${state.upcomingBooking?.orderable?.site?.name}';
    }
  }

  int getIdBooking(BuildContext context) {
    var state = BlocProvider.of<EditBookingBloc>(context).state;
    if (state.ongoingBooking != null) {
      return state.ongoingBooking?.id ?? 0;
    } else {
      return state.upcomingBooking?.id ?? 0;
    }
  }

  DateTime getFromDate() {
    if (widget.ongoingBooking != null) {
      return widget.ongoingBooking?.startDate ?? DateTime.now();
    } else {
      return widget.upcomingBooking?.startDate ?? DateTime.now();
    }
  }

  DateTime getToDate() {
    if (widget.ongoingBooking != null) {
      return widget.ongoingBooking?.endDate ?? DateTime.now();
    } else {
      return widget.upcomingBooking?.endDate ?? DateTime.now();
    }
  }

  DateTime getFromTime() {
    if (widget.ongoingBooking != null) {
      return Utilities().convertDoubleToTime(widget.ongoingBooking?.startTime ?? 0);
    } else {
      return Utilities().convertDoubleToTime(widget.upcomingBooking?.startTime ?? 0);
    }
  }

  DateTime getToTime() {
    if (widget.ongoingBooking != null) {
      return Utilities().convertDoubleToTime(widget.ongoingBooking?.endTime ?? 0);
    } else {
      return Utilities().convertDoubleToTime(widget.upcomingBooking?.endTime ?? 0);
    }
  }

  Widget alertIcon() {
    return Image.asset(
      ImagePath.alertIcon.assetName,
      isAntiAlias: true,
      filterQuality: FilterQuality.high,
      width: 16,
      height: 16,
      scale: 1.8,
    );
  }

  String getCancelText(BuildContext context) {
    var state = BlocProvider.of<EditBookingBloc>(context).state;
    if (state.ongoingBooking != null) {
      return 'End Booking';
    } else {
      return 'Cancel Booking';
    }
  }

  Future<void> showFromDatePicker({
    required BuildContext context,
  }) async {
    return await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return DateTimePickerBooking(
          modeDateTimePicker: CupertinoDatePickerMode.date,
          onPressCancel: () {
            Navigator.of(context).pop();
          },
          onPressDone: () {
            Future.delayed(const Duration(milliseconds: 500)).then((value) => setState(() {}));
            Navigator.of(context).pop();
          },
          onDateTimeChanged: (picked) {
            fromDate = picked;
          },
          initialDateTime: fromDate,
        );
      },
    ).then(
      (value) => showProgressIndicator(context),
    );
  }

  Future<void> showToDatePicker({
    required BuildContext context,
  }) async {
    return await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return DateTimePickerBooking(
          modeDateTimePicker: CupertinoDatePickerMode.date,
          onPressCancel: () {
            Navigator.of(context).pop();
          },
          onPressDone: () {
            Future.delayed(const Duration(milliseconds: 500)).then((value) => setState(() {}));
            Navigator.of(context).pop();
          },
          onDateTimeChanged: (picked) {
            toDate = picked;
          },
          initialDateTime: toDate,
        );
      },
    ).then(
      (value) => showProgressIndicator(context),
    );
  }

  Future<void> showFromTimePicker({
    required BuildContext context,
  }) async {
    return await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return DateTimePickerBooking(
          modeDateTimePicker: CupertinoDatePickerMode.time,
          onPressCancel: () {
            Navigator.of(context).pop();
          },
          onPressDone: () {
            Future.delayed(const Duration(milliseconds: 500)).then((value) => setState(() {}));
            Navigator.of(context).pop();
          },
          onDateTimeChanged: (picked) {
            fromTime = picked;
          },
          minuteInterval: 15,
          initialDateTime: fromTime,
        );
      },
    ).then(
      (value) => showProgressIndicator(context),
    );
  }

  Future<void> showToTimePicker({
    required BuildContext context,
  }) async {
    return await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return DateTimePickerBooking(
          modeDateTimePicker: CupertinoDatePickerMode.time,
          onPressCancel: () {
            Navigator.of(context).pop();
          },
          onPressDone: () {
            Future.delayed(const Duration(milliseconds: 500)).then((value) => setState(() {}));
            Navigator.of(context).pop();
          },
          onDateTimeChanged: (picked) {
            toTime = picked;
          },
          minuteInterval: 15,
          initialDateTime: toTime,
        );
      },
    ).then(
      (value) => showProgressIndicator(context),
    );
  }

  showProgressIndicator(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Center(
          child: CupertinoActivityIndicator(
            radius: 15,
            color: greenColor,
          ),
        );
      },
    );
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        Navigator.of(context).pop();
      },
    );
  }

  showProgressIndicatorDeleting(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Center(
          child: CupertinoActivityIndicator(
            radius: 15,
            color: greenColor,
          ),
        );
      },
    );
  }

  showDialogError(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          height: 300,
          visibleBackButton: false,
          visibleConfirmButton: true,
          stringConfirmButton: 'OK',
          errorMessage: Utilities().formatErrorMessage(errorMessage),
          visibleDialogMessage: false,
          visibleErrorMessage: true,
          colorConfirmButton: greenColor,
          onTapConfirmButton: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
