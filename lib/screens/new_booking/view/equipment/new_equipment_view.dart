import 'dart:developer';

import 'package:codebase/screens/new_booking/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../../../blocs/bloc/global_bloc.dart';
import '../../../../utilities/rest_api_client/index.dart';
import '../../../new_booking_select_time/new_booking_select_time_screen.dart';
import '../../decoration/index.dart';
import '../../widgets/index.dart';
import 'bloc/equipment_bloc.dart';

class NewEquipmentView extends StatelessWidget {
  const NewEquipmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EquipmentBloc(NewBookingRepository(restApiClient: RestAPIClient()))
        ..add(FetchDataEquipmentEvent()),
      child: BlocListener<EquipmentBloc, EquipmentState>(
        listener: (context, state) {
          log(state.runtimeType.toString());
          if (state is EquipmentSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              UpdateList(listNewEquipment: state.listEquipment),
            );
          } else if (state is EquipmentLikeSuccess) {
            BlocProvider.of<GlobalBloc>(context).add(
              GlobalToggleLikeEquipment(equipmentItem: state.equipmentItem),
            );
          }
        },
        child: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (context, state) {
            var bloc = context.read<EquipmentBloc>();
            return Column(
              children: [
                TextFieldSearchNewBooking(
                  controller: bloc.equipmentTextEditingController,
                  onChanged: (value) {
                    bloc.add(
                      SearchEquipmentEvent(),
                    );
                  },
                ),
                Flexible(
                  child: SmartRefresher(
                    enablePullUp: true,
                    enablePullDown: true,
                    header: MaterialClassicHeader(color: greenColor),
                    footer: const LoadMoreWidget(),
                    onRefresh: () {
                      bloc.add(RefreshEquipmentEvent());
                    },
                    onLoading: () {
                      bloc.add(LoadMoreEquipmentEvent());
                    },
                    controller: bloc.equipmentRefreshController,
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
                          itemCount: state.listNewEquipment.length,
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
    var localBloc = BlocProvider.of<EquipmentBloc>(context);
    var globalBloc = BlocProvider.of<GlobalBloc>(context);
    var itemListEquipment = globalBloc.state.listNewEquipment[index];
    String nameEquipment = itemListEquipment.name ?? '';
    Color? colorTagEquipment =
        Color(int.parse('0xff${itemListEquipment.site?.colorTag?.replaceAll('#', '')}'));
    String? levelEquipment = itemListEquipment.site?.level.toString();
    String? siteNameEquipment = itemListEquipment.site?.name;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
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
        decoration: equipmentsItemNewBookingsBoxDecoration,
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
                    data: nameEquipment,
                    textStyle: nameEquipmentNewBookingsTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: InkWell(
                    onTap: () {
                      localBloc.add(
                        ToggleLikeEquipmentEvent(equipmentItem: itemListEquipment),
                      );
                    },
                    child: Icon(
                      (itemListEquipment.isLiked ?? true)
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
                    width: 265,
                    child: TextWidgetItemNewBooking(
                      data: 'Level $levelEquipment, $siteNameEquipment',
                      textStyle: levelAndTypeEquipmentNewBookingsTextStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: () {},
                    child: ImageIcon(
                      AssetImage(
                        ImagePath.infoIcon.assetName,
                      ),
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
}
