import 'package:codebase/screens/filter_search_booking/bloc/filter_search_bloc.dart';
import 'package:codebase/screens/filter_search_booking/filter_search_booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/colors/colors.dart';
import 'package:shared_ui/path/image_path.dart';
import 'package:shared_ui/styles/index.dart';

import '../../utilities/rest_api_client/api_client.dart';
import 'widgets/index.dart';

class FilterSearchBookingScreen extends StatelessWidget {
  const FilterSearchBookingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterSearchBloc(FilterSearchBookingRepository(RestAPIClient())),
      child: BlocConsumer<FilterSearchBloc, FilterSearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FilterSearchInitial) {
              final bloc = context.read<FilterSearchBloc>();
              bloc.add(FetchDataFilterEvent());
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
                      'Filter',
                      style: titleAppBarTextStyle,
                    ),
                  ),
                  body: const Center(
                    child: CircularProgressIndicator(),
                  ));
            } else if (state is FilterSearchSuccess) {
              final bloc = context.read<FilterSearchBloc>();
              var responseLevel = state.responseLevel;
              var responseSite = state.responseSite;
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          ImagePath.checkIcon.assetName,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    )
                  ],
                  elevation: 1,
                  centerTitle: true,
                  title: Text(
                    'Filter',
                    style: titleAppBarTextStyle,
                  ),
                ),
                body: RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(
                      const Duration(seconds: 1),
                    );
                  },
                  child: SingleChildScrollView(
                    controller: bloc.scrollController,
                    physics: bloc.physics,
                    child: Column(
                      children: [
                        TextWidgetTitleListAndResetButton(
                          padding: const EdgeInsets.fromLTRB(24, 20, 24, 13),
                          dataTitleListFilter: 'Level',
                          dataTextButton: 'Reset',
                          onTapResetButton: () {},
                        ),
                        SizedBox(
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 364,
                                height: 58,
                                color: superLightGreyColor,
                                padding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Level ${responseLevel?[index]}',
                                      style: TextStyle(
                                        color: blackColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD9DBE9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Transform.scale(
                                        alignment: Alignment.center,
                                        scale: 1.35,
                                        child: Checkbox(
                                          visualDensity: VisualDensity.compact,
                                          onChanged: (bool? value) {},
                                          value: bloc.isCheckedLevel[index],
                                          shape: const CircleBorder(),
                                          activeColor: greenColor,
                                          focusColor: redColor,
                                          hoverColor: Colors.transparent,
                                          side: MaterialStateBorderSide.resolveWith(
                                            (states) => const BorderSide(
                                              width: 1.0,
                                              color: Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: separatorBuilder,
                            itemCount: responseLevel!.length,
                          ),
                        ),
                        TextWidgetTitleListAndResetButton(
                          padding: const EdgeInsets.fromLTRB(24, 20, 24, 13),
                          dataTitleListFilter: 'Room',
                          dataTextButton: 'Reset',
                          onTapResetButton: () {},
                        ),
                        SizedBox(
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              final bloc = context.read<FilterSearchBloc>();
                              return Container(
                                width: 364,
                                height: 58,
                                color: superLightGreyColor,
                                padding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        responseSite?[index].name ?? '',
                                        style: TextStyle(
                                          color: blackColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD9DBE9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Transform.scale(
                                        alignment: Alignment.center,
                                        scale: 1.35,
                                        child: Checkbox(
                                          visualDensity: VisualDensity.compact,
                                          onChanged: (bool? value) {},
                                          value: bloc.isCheckedRoom[index],
                                          shape: const CircleBorder(),
                                          activeColor: greenColor,
                                          focusColor: redColor,
                                          hoverColor: Colors.transparent,
                                          side: MaterialStateBorderSide.resolveWith(
                                            (states) => const BorderSide(
                                              width: 1.0,
                                              color: Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: separatorBuilder,
                            itemCount: responseSite!.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          }),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      height: 10,
    );
  }
}
