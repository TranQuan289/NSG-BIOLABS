import 'package:flutter/material.dart';
import 'package:shared_ui/colors/index.dart';
import 'package:shared_ui/styles/index.dart';

import '../new_booking/view/index.dart';
import 'view/equipment/favourite_equipment_view.dart';
import 'view/meeting_room/favourite_meeting_room_view.dart';
import 'widgets/index.dart';

class FavouriteBookingScreen extends StatefulWidget {
  const FavouriteBookingScreen({super.key});

  @override
  State<FavouriteBookingScreen> createState() => _FavouriteBookingScreenState();
}

class _FavouriteBookingScreenState extends State<FavouriteBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'My Favourites',
          style: titleAppBarTextStyle,
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              child: TabBar(
                indicatorColor: greenColor,
                labelColor: greenColor,
                unselectedLabelColor: Colors.grey,
                indicatorWeight: 3,
                tabs: [
                  Container(
                    width: double.infinity,
                    height: 62,
                    alignment: Alignment.center,
                    child: TextWidgetTabFavourite(
                      data: 'Equipments',
                      textStyle: tabBarItemFavouriteBookingsTextStyle,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 62,
                    alignment: Alignment.center,
                    child: TextWidgetTabFavourite(
                      data: 'Meeting Room',
                      textStyle: tabBarItemFavouriteBookingsTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  FavouriteEquipmentView(),
                  FavouriteMeetingRoomView(),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButtonFavourite(
        onPressed: goToNewBookingScreen,
      ),
    );
  }

  goToNewBookingScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NewBookingScreen(),
      ),
    );
  }
}
