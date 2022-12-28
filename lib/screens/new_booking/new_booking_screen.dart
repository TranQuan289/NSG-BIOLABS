import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import '../filter_search_booking/index.dart';
import 'view/index.dart';
import 'widgets/index.dart';

class NewBookingScreen extends StatefulWidget {
  const NewBookingScreen({super.key});

  @override
  State<NewBookingScreen> createState() => _NewBookingScreenState();
}

class _NewBookingScreenState extends State<NewBookingScreen> {
  bool visible = true;
  int initialIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          Visibility(
            visible: visible,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FilterSearchBookingScreen(),
                  ));
                },
                child: Image.asset(
                  ImagePath.filterIcon.assetName,
                  width: 18,
                  height: 19,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: primaryColor,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'NSG Biolab',
          style: titleAppBarTextStyle,
        ),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: initialIndex,
        child: Column(
          children: [
            SizedBox(
              child: TabBar(
                onTap: (value) {
                  if (value == 0) {
                    setState(() {
                      visible = true;
                    });
                  } else {
                    setState(() {
                      visible = false;
                    });
                  }
                },
                indicatorColor: greenColor,
                labelColor: greenColor,
                unselectedLabelColor: Colors.grey,
                indicatorWeight: 3,
                tabs: [
                  Container(
                    width: double.infinity,
                    height: 62,
                    alignment: Alignment.center,
                    child: TextWidgetTabNewBooking(
                      data: 'Equipments',
                      textStyle: tabBarItemNewBookingsTextStyle,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 62,
                    alignment: Alignment.center,
                    child: TextWidgetTabNewBooking(
                      data: 'Meeting Room',
                      textStyle: tabBarItemNewBookingsTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  NewEquipmentView(),
                  NewMeetingRoomView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
