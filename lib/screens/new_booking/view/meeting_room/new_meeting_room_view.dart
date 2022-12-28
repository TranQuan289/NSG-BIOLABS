import 'package:codebase/screens/new_booking/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../../../blocs/bloc/global_bloc.dart';
import '../../../../utilities/rest_api_client/api_client.dart';
import '../../../new_booking_select_time/new_booking_select_time_screen.dart';
import '../../decoration/index.dart';
import '../../widgets/index.dart';
import 'bloc/meeting_room_bloc.dart';

class NewMeetingRoomView extends StatelessWidget {
  const NewMeetingRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MeetingRoomBloc(NewBookingRepository(restApiClient: RestAPIClient()))
        ..add(FetchDataMeetingRoomEvent()),
      child: BlocListener<MeetingRoomBloc, MeetingRoomState>(
        listener: (context, state) {
          if (state is MeetingRoomSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              UpdateList(
                listNewMeetingRoom: state.listMeetingRoom,
              ),
            );
          } else
           if (state is MeetingRoomLikeSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              GlobalToggleLikeMeetingRoom(
                meetingRoomItem: state.meetingRoomItem,
              ),
            );
          }
        },
        child: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (context, state) {
            var bloc = context.read<MeetingRoomBloc>();
            return Column(
              children: [
                TextFieldSearchNewBooking(
                  controller: bloc.meetingRoomTextEditingController,
                  onChanged: (value) {
                    bloc.add(
                      SearchMeetingRoomEvent(),
                    );
                  },
                ),
                Expanded(
                  child: SmartRefresher(
                    enablePullUp: true,
                    enablePullDown: true,
                    header: MaterialClassicHeader(color: greenColor),
                    footer: const LoadMoreWidget(),
                    onRefresh: () {
                      bloc.add(RefreshMeetingRoomEvent());
                    },
                    onLoading: () {
                      bloc.add(LoadMoreMeetingRoomEvent());
                    },
                    controller: bloc.meetingRoomRefreshController,
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      primary: true,
                      child: SizedBox(
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: itemBuilder,
                          separatorBuilder: separatorBuilder,
                          itemCount: state.listNewMeetingRoom.length,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      height: 15,
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var localBloc = BlocProvider.of<MeetingRoomBloc>(context);
    var globalBloc = BlocProvider.of<GlobalBloc>(context);
    var itemListMeetingRoom = globalBloc.state.listNewMeetingRoom[index];
    String nameMeetingRoom = itemListMeetingRoom.name ?? '';
    Color? colorTagMeetingRoom =
        Color(int.parse('0xff${itemListMeetingRoom.site?.colorTag?.replaceAll('#', '')}'));
    String? levelMeetingRoom = itemListMeetingRoom.site?.level.toString();
    String? siteNameMeetingRoom = itemListMeetingRoom.site?.name;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewBookingSelectTimeScreen(
              meetingRoomItem: itemListMeetingRoom,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(17, 5, 20, 0),
        width: 366,
        decoration: meetingRoomItemNewBookingsBoxDecoration,
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
                  child: TextWidgetItemNewBooking(
                    data: nameMeetingRoom,
                    textStyle: nameMeetingRoomNewBookingsTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: InkWell(
                    onTap: () {
                      localBloc.add(
                        ToggleLikeMeetingRoomEvent(
                          meetingRoomItem: itemListMeetingRoom,
                        ),
                      );
                    },
                    child: Icon(
                      (itemListMeetingRoom.isLiked ?? true)
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: greenColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
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
                          color: colorTagMeetingRoom,
                          width: 8,
                        ),
                      ),
                    ),
                    width: 265,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: TextWidgetItemNewBooking(
                        data: 'Level $levelMeetingRoom, $siteNameMeetingRoom',
                        textStyle: levelAndTypeMeetingRoomNewBookingsTextStyle,
                      ),
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
    );
  }
}
