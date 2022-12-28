import 'package:codebase/blocs/bloc/global_bloc.dart';
import 'package:codebase/screens/favourite_booking/favourite_booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_ui/colors/index.dart';
import 'package:shared_ui/components/load_more_widget.dart';
import 'package:shared_ui/styles/index.dart';

import '../../../../utilities/rest_api_client/index.dart';
import '../../../new_booking_select_time/new_booking_select_time_screen.dart';
import '../../decoration/index.dart';
import '../../widgets/index.dart';
import 'bloc/meeting_room_bloc.dart';

class FavouriteMeetingRoomView extends StatelessWidget {
  const FavouriteMeetingRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MeetingRoomBloc(FavouriteBookingRepository(restApiClient: RestAPIClient()))
            ..add(FetchDataMeetingRoomEvent()),
      child: BlocListener<MeetingRoomBloc, MeetingRoomState>(
        listener: (context, state) {
          if (state is MeetingRoomSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              UpdateList(
                listMeetingRoom: state.listMeetingRoom,
              ),
            );
          } else if (state is MeetingRoomLikeSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              GlobalToggleLikeMeetingRoom(
                meetingRoomItem: state.favouriteMeetingRoom,
              ),
            );
          }
        },
        child: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (context, state) {
            return Stack(
              children: [
                Center(
                  child: BackgroundEmptyDataFavourite(
                    visibility: state.listMeetingRoom.isNotEmpty ? false : true,
                    notificationData: 'You have no favourite Meeting Room',
                    startMessageRequiredData: 'Click the',
                    endMessageRequiredData: 'to save to My Favourites',
                  ),
                ),
                Visibility(
                  visible: true,
                  child: SmartRefresher(
                    enablePullUp: state.listMeetingRoom.isNotEmpty ? true : false,
                    enablePullDown: true,
                    header: MaterialClassicHeader(color: greenColor),
                    footer: const LoadMoreWidget(),
                    onLoading: () {
                      context.read<MeetingRoomBloc>().add(LoadMoreMeetingRoomEvent());
                    },
                    onRefresh: () {
                      context.read<MeetingRoomBloc>().add(RefreshMeetingRoomEvent());
                    },
                    controller: context.read<MeetingRoomBloc>().meetingRoomRefreshController,
                    child: SingleChildScrollView(
                      primary: true,
                      child: SizedBox(
                        child: ListView.separated(
                          primary: true,
                          padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: itemBuilder,
                          separatorBuilder: separatorBuilder,
                          itemCount: state.listMeetingRoom.length,
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

  Widget itemBuilder(BuildContext context, int index) {
    var globalBloc = BlocProvider.of<GlobalBloc>(context);
    var localBloc = BlocProvider.of<MeetingRoomBloc>(context);
    var itemListMeetingRoom = globalBloc.state.listMeetingRoom[index];
    Color? colorTagMeetingRoom =
        Color(int.parse('0xff${itemListMeetingRoom.site?.colorTag?.replaceAll('#', '')}'));
    String? levelMeetingRoom = itemListMeetingRoom.site?.level.toString();
    String? siteNameMeetingRoom = itemListMeetingRoom.site?.name;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
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
        decoration: meetingRoomItemFavouriteBookingsBoxDecoration,
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
                  child: TextWidgetItemFavourite(
                    data: itemListMeetingRoom.name ?? '',
                    textStyle: nameMeetingRoomFavoriteBookingsTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: InkWell(
                    onTap: () {
                      localBloc.add(
                        ToggleLikeMeetingRoomEvent(
                          favouriteMeetingRoom: itemListMeetingRoom,
                        ),
                      );
                    },
                    child: Icon(
                      Icons.favorite,
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
                        left: BorderSide(color: colorTagMeetingRoom, width: 8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: TextWidgetItemFavourite(
                        data: 'Level $levelMeetingRoom, $siteNameMeetingRoom',
                        textStyle: levelAndTypeMeetingRoomFavoriteBookingsTextStyle,
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

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      height: 15,
    );
  }
}
