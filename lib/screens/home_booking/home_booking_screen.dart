import 'dart:developer';

import 'package:codebase/blocs/bloc/global_bloc.dart';
import 'package:codebase/screens/details_meeting_room_booking/details_meeting_room_booking_screen.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../utilities/index.dart';
import '../../utilities/rest_api_client/index.dart';
import '../details_equipment_booking/details_equipment_booking_screen.dart';
import '../new_booking/new_booking_screen.dart';
import 'bloc/home_booking_bloc.dart';
import 'index.dart';
import 'widgets/index.dart';

class HomeBookingScreen extends StatefulWidget {
  const HomeBookingScreen({super.key});

  @override
  State<HomeBookingScreen> createState() => _HomeBookingScreenState();
}

class _HomeBookingScreenState extends State<HomeBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBookingBloc(
        HomeBookingRepository(
          restApiClient: RestAPIClient(),
        ),
      )..add(FetchDataHomeBookingEvent()),
      child: BlocListener<HomeBookingBloc, HomeBookingState>(
        listener: (context, state) {
          if (state is HomeBookingSucess) {
            BlocProvider.of<GlobalBloc>(context).add(
              UpdateList(
                listOngoingBooking: state.listOngoingBooking,
                listUpcomingBooking: state.listUpcomingBooking,
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 1,
            centerTitle: true,
            title: Text(
              'NSG Biolab',
              style: titleAppBarTextStyle,
            ),
          ),
          body: BlocBuilder<GlobalBloc, GlobalState>(
            builder: (context, state) {
              var bloc = context.read<HomeBookingBloc>();
              if (state is HomeBookingInitial) {
                return const LoadingPageWidget();
              }
              var listOngoingBooking = state.listOngoingBooking;
              var listUpcomingBooking = state.listUpcomingBooking;
              return Column(
                children: [
                  Flexible(
                    child: SmartRefresher(
                      enablePullUp: true,
                      enablePullDown: true,
                      header: MaterialClassicHeader(color: greenColor),
                      footer: const LoadMoreWidget(),
                      onLoading: () {
                        bloc.add(LoadMoreUpcomingBookingEvent());
                      },
                      onRefresh: () {
                        bloc.add(RefreshUpcomingBookingEvent());
                      },
                      controller: bloc.refreshController,
                      child: Stack(
                        children: [
                          BackGroundEmptyDataHome(
                            visibility: listUpcomingBooking.isNotEmpty ? false : true,
                            notificationData: 'You have no active bookings',
                            startMessageRequiredData: 'Click the',
                            endMessageRequiredData: 'below to add new bookings',
                          ),
                          Visibility(
                            visible: listUpcomingBooking.isNotEmpty ? true : false,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  Visibility(
                                    visible: listOngoingBooking.isNotEmpty ? true : false,
                                    child: const TitleListWidgetHome(
                                      titleListBooking: 'My Ongoing Bookings',
                                    ),
                                  ),
                                  Visibility(
                                    visible: listOngoingBooking.isNotEmpty ? true : false,
                                    child: SizedBox(
                                      child: ListView.separated(
                                        padding: const EdgeInsets.fromLTRB(24, 22, 24, 10),
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: itemBuilderOngoing,
                                        separatorBuilder: separatorBuilder,
                                        itemCount: listOngoingBooking.length,
                                      ),
                                    ),
                                  ),
                                  const TitleListWidgetHome(
                                    titleListBooking: 'My Upcoming Bookings',
                                  ),
                                  SizedBox(
                                    child: ListView.separated(
                                      padding: const EdgeInsets.fromLTRB(24, 22, 24, 0),
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: itemBuilderUpcoming,
                                      separatorBuilder: separatorBuilder,
                                      itemCount: listUpcomingBooking.length,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              );
            },
          ),
          floatingActionButton: floatingActionButton(),
        ),
      ),
    );
  }

  Widget itemBuilderOngoing(BuildContext context, int index) {
    var globalBloc = BlocProvider.of<GlobalBloc>(context);
    var itemListOngoingBooking = globalBloc.state.listOngoingBooking[index];
    String? levelOngoing = itemListOngoingBooking.orderable?.site?.level.toString();
    String? siteNameOngoing = itemListOngoingBooking.orderable?.site?.name;
    String orderableNameOngoing = itemListOngoingBooking.orderable?.name ?? '';
    Color? colorTagOngoing = Color(
        int.parse('0xff${itemListOngoingBooking.orderable?.site?.colorTag?.replaceAll('#', '')}'));
    String startDateOngoing =
        Utilities().dateFormat(itemListOngoingBooking.startDate ?? DateTime.now(), 'MMM d (EEE)');
    String startTimeOngoing = Utilities()
        .timeFormat(Utilities().convertDoubleToTime(itemListOngoingBooking.startTime ?? 0));
    String endTimeOngoing = Utilities()
        .timeFormat(Utilities().convertDoubleToTime(itemListOngoingBooking.endTime ?? 0));
    return GestureDetector(
      onTap: () {
        checkTypeBooking(itemListOngoingBooking.orderableType ?? '')
            ? goToDetailsEquipmentScreen(
                ongoingBooking: itemListOngoingBooking,
                checkBooking: true,
              )
            : goToDetailsMeetingRoomScreen(
                ongoingBooking: itemListOngoingBooking,
                checkBooking: true,
              );
      },
      child: Stack(
        children: [
          Container(
            width: 366,
            height: 115,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              border: Border.all(
                width: 1,
                color: lightGreyColor,
                style: BorderStyle.solid,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  TextWidgetItemHome(
                    data: orderableNameOngoing,
                    textStyle: nameBookingsTextStyle,
                  ),
                  const SizedBox(height: 20),
                  TextWidgetItemHome(
                    data: 'Level $levelOngoing, $siteNameOngoing',
                    textStyle: nameSiteBookingsTextStyle,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      TextWidgetItemHome(
                        data: startDateOngoing,
                        textStyle: startDateBookingsTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: SizedBox(
                          width: 100,
                          child: TextWidgetItemHome(
                            textStyle: timeBookingsTextStyle,
                            data: '$startTimeOngoing - $endTimeOngoing ',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 8,
            height: 115,
            decoration: BoxDecoration(
              color: colorTagOngoing,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBuilderUpcoming(BuildContext context, int index) {
    var globalBloc = BlocProvider.of<GlobalBloc>(context);
    var itemListUpcomingBooking = globalBloc.state.listUpcomingBooking[index];
    String? levelUpcoming = itemListUpcomingBooking.orderable?.site?.level.toString();
    String? siteNameUpcoming = itemListUpcomingBooking.orderable?.site?.name;
    String orderableNameUpcoming = itemListUpcomingBooking.orderable?.name ?? '';
    Color? colorTagUpcoming = Color(
        int.parse('0xff${itemListUpcomingBooking.orderable?.site?.colorTag?.replaceAll('#', '')}'));
    String startDateUpcoming =
        Utilities().dateFormat(itemListUpcomingBooking.startDate ?? DateTime.now(), 'MMM d (EEE)');
    String startTimeUpcoming = Utilities()
        .timeFormat(Utilities().convertDoubleToTime(itemListUpcomingBooking.startTime ?? 0));
    String endTimeUpcoming = Utilities()
        .timeFormat(Utilities().convertDoubleToTime(itemListUpcomingBooking.endTime ?? 0));
    return GestureDetector(
      onTap: () {
        checkTypeBooking(itemListUpcomingBooking.orderableType ?? '')
            ? goToDetailsEquipmentScreen(
                upcomingBooking: itemListUpcomingBooking,
                checkBooking: false,
              )
            : goToDetailsMeetingRoomScreen(
                upcomingBooking: itemListUpcomingBooking,
                checkBooking: false,
              );
      },
      child: Stack(
        children: [
          Container(
            width: 366,
            height: 115,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              border: Border.all(
                width: 1,
                color: lightGreyColor,
                style: BorderStyle.solid,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  TextWidgetItemHome(
                    data: orderableNameUpcoming,
                    textStyle: nameBookingsTextStyle,
                  ),
                  const SizedBox(height: 20),
                  TextWidgetItemHome(
                    data: 'Level $levelUpcoming, $siteNameUpcoming',
                    textStyle: nameSiteBookingsTextStyle,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      TextWidgetItemHome(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                        data: startDateUpcoming,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: SizedBox(
                          width: 100,
                          child: TextWidgetItemHome(
                            textStyle: timeBookingsTextStyle,
                            data: '$startTimeUpcoming - $endTimeUpcoming',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 8,
            height: 115,
            decoration: BoxDecoration(
              color: colorTagUpcoming,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      height: 15,
    );
  }

  bool checkTypeBooking(String orderableType) {
    if (orderableType.contains('EquipmentItem')) {
      return true;
    } else if (orderableType.contains('MeetingRoom')) {
      return false;
    } else {
      return false;
    }
  }

  Widget floatingActionButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 9, 64),
      child: SizedBox(
        width: 62,
        height: 62,
        child: FloatingActionButton(
          onPressed: () {
            log('Click');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NewBookingScreen(),
              ),
            );
          },
          backgroundColor: greenColor,
          child: Icon(
            Icons.add,
            color: primaryColor,
          ),
        ),
      ),
    );
  }

  goToDetailsEquipmentScreen({
    OngoingBooking? ongoingBooking,
    UpcomingBooking? upcomingBooking,
    required bool checkBooking,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailsEquipmentBookingScreen(
          ongoingBooking: ongoingBooking,
          upcomingBooking: upcomingBooking,
          checkBooking: checkBooking,
        ),
      ),
    );
  }

  goToDetailsMeetingRoomScreen({
    OngoingBooking? ongoingBooking,
    UpcomingBooking? upcomingBooking,
    required bool checkBooking,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailsMeetingRoomBookingScreen(
          ongoingBooking: ongoingBooking,
          upcomingBooking: upcomingBooking,
          checkBooking: checkBooking,
        ),
      ),
    );
  }
}
