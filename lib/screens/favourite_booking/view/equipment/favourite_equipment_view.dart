import 'package:codebase/blocs/bloc/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_ui/colors/index.dart';
import 'package:shared_ui/components/load_more_widget.dart';
import 'package:shared_ui/path/image_path.dart';
import 'package:shared_ui/styles/index.dart';

import '../../../../utilities/rest_api_client/index.dart';
import '../../../new_booking_select_time/new_booking_select_time_screen.dart';
import '../../decoration/index.dart';
import '../../index.dart';
import '../../widgets/index.dart';
import 'bloc/equipment_bloc.dart';

class FavouriteEquipmentView extends StatelessWidget {
  const FavouriteEquipmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EquipmentBloc(FavouriteBookingRepository(restApiClient: RestAPIClient()))
        ..add(FetchDataEquipmentEvent()),
      child: BlocListener<EquipmentBloc, EquipmentState>(
        listener: (context, state) {
          if (state is EquipmentSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              UpdateList(
                listEquipment: state.listEquipment,
              ),
            );
          } else if (state is EquipmentLikeSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              GlobalToggleLikeEquipment(
                equipmentItem: state.favouriteEquipment,
              ),
            );
          }
        },
        child: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (context, state) {
            return Stack(
              children: [
                BackgroundEmptyDataFavourite(
                  visibility: state.listEquipment.isNotEmpty ? false : true,
                  notificationData: 'You have no favourite Equipment',
                  startMessageRequiredData: 'Click the',
                  endMessageRequiredData: 'to save to My Favourites',
                ),
                SmartRefresher(
                  enablePullUp: state.listEquipment.isNotEmpty ? true : false,
                  enablePullDown: true,
                  header: MaterialClassicHeader(color: greenColor),
                  footer: const LoadMoreWidget(),
                  onLoading: () {
                    context.read<EquipmentBloc>().add(LoadMoreEquipmentEvent());
                  },
                  onRefresh: () {
                    context.read<EquipmentBloc>().add(RefreshEquipmentEvent());
                  },
                  controller: context.read<EquipmentBloc>().equipmentRefreshController,
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
                        itemCount: state.listEquipment.length,
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
    var localBloc = BlocProvider.of<EquipmentBloc>(context);
    var globalBloc = BlocProvider.of<GlobalBloc>(context);
    var itemListEquipment = globalBloc.state.listEquipment[index];
    Color? colorTagEquipment =
        Color(int.parse('0xff${itemListEquipment.site?.colorTag?.replaceAll('#', '')}'));
    String? levelEquipment = itemListEquipment.site?.level.toString();
    String? siteNameEquipment = itemListEquipment.site?.name;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewBookingSelectTimeScreen(
              equipmentItem: itemListEquipment,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(17, 5, 20, 0),
        width: 366,
        decoration: equipmentsItemFavouriteBookingsBoxDecoration,
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
                    data: itemListEquipment.name ?? '',
                    textStyle: nameEquipmentFavoriteBookingsTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: InkWell(
                    onTap: () {
                      localBloc.add(
                        ToggleLikeEquipmentEvent(
                          favouriteEquipment: itemListEquipment,
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
                        left: BorderSide(color: colorTagEquipment, width: 8),
                      ),
                    ),
                    child: TextWidgetItemFavourite(
                      data: 'Level $levelEquipment, $siteNameEquipment',
                      textStyle: levelAndTypeEquipmentFavoriteBookingsTextStyle,
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
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      height: 15,
    );
  }
}
