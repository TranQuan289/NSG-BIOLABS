// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import '../favourite_booking/favourite_booking_screen.dart';
import '../home_booking/home_booking_screen.dart';
import '../profile/profile_screen.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({Key? key}) : super(key: key);

  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

final List<Map<String, dynamic>> _pageDetails = [
  {
    'pageName': const HomeBookingScreen(),
  },
  {'pageName': const FavouriteBookingScreen()},
  {'pageName': const ProfileScreen()},
];
var _selectPageIndex = 0;

class _NavigatorScreenState extends State<NavigatorScreen> {
  @override
  void initState() {
    _selectPageIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _pageDetails[_selectPageIndex]['pageName'],
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _selectPageIndex == 0
                      ? Container(
                          color: greenColor,
                          height: 4,
                        )
                      : blankColorIndicatorUnSelectedBottomNavigationBarItem(),
                ),
                Expanded(
                  flex: 1,
                  child: _selectPageIndex == 1
                      ? Container(
                          color: redColor,
                          height: 4,
                        )
                      : blankColorIndicatorUnSelectedBottomNavigationBarItem(),
                ),
                Expanded(
                  flex: 1,
                  child: _selectPageIndex == 2
                      ? Container(
                          color: orangeColor,
                          height: 4,
                        )
                      : blankColorIndicatorUnSelectedBottomNavigationBarItem(),
                ),
              ],
            ),
          ),
          BottomNavigationBar(
            elevation: 15,
            unselectedFontSize: 14,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            selectedItemColor: selecItemColor(_selectPageIndex),
            currentIndex: _selectPageIndex,
            onTap: (value) {
              setState(() {
                _selectPageIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 7, 0, 9),
                      child: Image.asset(
                        ImagePath.homeIcon.assetName,
                        width: 20,
                        height: 18.59,
                        color: _selectPageIndex == 0 ? greenColor : null,
                      ),
                    ),
                  ],
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.fromLTRB(0, 7, 0, 9),
                  child: Image.asset(
                    ImagePath.favoriteIcon.assetName,
                    width: 20,
                    height: 18.59,
                    color: _selectPageIndex == 1 ? redColor : null,
                  ),
                ),
                label: 'My Favourites',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.fromLTRB(0, 7, 0, 9),
                  child: Image.asset(
                    ImagePath.profileIcon.assetName,
                    width: 20,
                    height: 18.59,
                    color: _selectPageIndex == 2 ? orangeColor : null,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }

  selecItemColor(int selectPageIndex) {
    switch (selectPageIndex) {
      case 0:
        return greenColor;
      case 1:
        return redColor;
      case 2:
        return orangeColor;
      default:
        null;
    }
  }
}

Widget blankColorIndicatorUnSelectedBottomNavigationBarItem() {
  return Container(
    color: Colors.transparent,
    height: 4,
  );
}
