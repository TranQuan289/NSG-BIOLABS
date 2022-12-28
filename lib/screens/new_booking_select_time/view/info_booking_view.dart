import 'dart:developer';

import 'package:codebase/blocs/bloc/global_bloc.dart';
import 'package:codebase/utilities/rest_api_client/api_client.dart';
import 'package:domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import '../new_booking_select_time_repository.dart';
import '../widgets/text_widget_info.dart';
import 'bloc/info_booking_bloc.dart';

class InfoBookingView extends StatefulWidget {
  const InfoBookingView({super.key, this.equipmentItem, this.meetingRoomItem});
  final EquipmentItem? equipmentItem;
  final MeetingRoomItem? meetingRoomItem;

  @override
  State<InfoBookingView> createState() => _InfoBookingViewState();
}

class _InfoBookingViewState extends State<InfoBookingView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InfoBookingBloc(NewBookingSelectTimeRepository(restApiClient: RestAPIClient()))
            ..add(
              FetchDataInfoBookingEvent(
                equipmentItem: widget.equipmentItem,
                meetingRoomItem: widget.meetingRoomItem,
              ),
            ),
      child: BlocConsumer<InfoBookingBloc, InfoBookingState>(
        listener: (context, state) {
          if (state is InfoBookingLikeSuccess) {
            if (state.equipmentItem != null) {
              BlocProvider.of<GlobalBloc>(context).add(
                GlobalToggleLikeEquipment(
                  equipmentItem: state.equipmentItem!,
                ),
              );
              BlocProvider.of<GlobalBloc>(context).add(UpdateList());
            } else {
              BlocProvider.of<GlobalBloc>(context).add(
                GlobalToggleLikeMeetingRoom(
                  meetingRoomItem: state.meetingRoomItem!,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          log(state.runtimeType.toString());
          var bloc = BlocProvider.of<InfoBookingBloc>(context);
          if (state is InfoBookingInitial) {
            return const SizedBox();
          }
          return Positioned(
            top: 81,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Material(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidgetInfo(
                                data: getInfoBookingName(context),
                                textStyle: nameDetailsTextStyle(),
                              ),
                              TextWidgetInfo(
                                data: getInfoBookingId(context),
                                textStyle: idDetailsTextStyle(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 23),
                          child: InkWell(
                            onTap: () {
                              if (state.equipmentItem != null) {
                                bloc.add(
                                  ToggleLikeInfoBookingEvent(
                                    equipmentItem: state.equipmentItem,
                                  ),
                                );
                              } else {
                                bloc.add(
                                  ToggleLikeInfoBookingEvent(
                                    meetingRoomItem: state.meetingRoomItem,
                                  ),
                                );
                              }
                            },
                            child: Icon(
                              isLike(context) ? Icons.favorite : Icons.favorite_outline,
                              color: greenColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(left: 9),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: getColorInfoBooking(context),
                                  width: 8,
                                ),
                              ),
                            ),
                            child: TextWidgetInfo(
                              data: getInfoBookingLevelAndSiteName(context),
                              textStyle: levelAndSiteNameDetailsTextStyle(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {},
                            child: ImageIcon(
                              AssetImage(ImagePath.infoIcon.assetName),
                              color: greenColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
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

  String getInfoBookingName(BuildContext context) {
    var state = BlocProvider.of<InfoBookingBloc>(context).state;
    if (state.equipmentItem != null) {
      return '${state.equipmentItem?.name}';
    } else {
      return '${state.meetingRoomItem?.name}';
    }
  }

  String getInfoBookingId(BuildContext context) {
    var state = BlocProvider.of<InfoBookingBloc>(context).state;
    if (state.equipmentItem != null) {
      return 'NSG-00${state.equipmentItem?.id}';
    } else {
      return 'NSG-00${state.meetingRoomItem?.id}';
    }
  }

  String getInfoBookingLevelAndSiteName(BuildContext context) {
    var state = BlocProvider.of<InfoBookingBloc>(context).state;
    if (state.equipmentItem != null) {
      return 'Level ${state.equipmentItem?.site?.level}, ${state.equipmentItem?.site?.name}';
    } else {
      return 'Level ${state.meetingRoomItem?.site?.level}, ${state.meetingRoomItem?.site?.name}';
    }
  }

  Color getColorInfoBooking(BuildContext context) {
    var state = BlocProvider.of<InfoBookingBloc>(context).state;
    if (state.equipmentItem != null) {
      return Color(int.parse('0xff${state.equipmentItem?.site?.colorTag?.replaceAll('#', '')}'));
    } else {
      return Color(int.parse('0xff${state.meetingRoomItem?.site?.colorTag?.replaceAll('#', '')}'));
    }
  }

  bool isLike(BuildContext context) {
    var state = BlocProvider.of<InfoBookingBloc>(context).state;
    // if (state is InfoBookingSuccess) {

    // } else {
    //   return false;
    // }

    if (state.equipmentItem != null) {
      log('---${state.equipmentItem?.isLiked}');
      log('---${state.runtimeType.toString()}');
      return state.equipmentItem?.isLiked ?? false;
    } else {
      log('---${state.meetingRoomItem?.isLiked}');
      log('---${state.runtimeType.toString()}');

      return state.meetingRoomItem?.isLiked ?? false;
    }
  }
}
