import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

TextStyle normalBlackTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: blackColor);
TextStyle normalWhiteTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: primaryColor);
TextStyle normalHintTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: hintColor);
TextStyle normalGreenTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: greenColor);
TextStyle normalRedTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: redColor);
TextStyle titleTextStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
TextStyle titleboldTextStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w900);
TextStyle timeTextStyle =
    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF555555));
TextStyle timeSlotTextStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: greenColor);
TextStyle timeSlotErrorTextStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: redColor);

// Home screen style
TextStyle titleAppBarTextStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: blackColor);
TextStyle myUpComingBookingsTextStyle =
    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF41524B));
TextStyle nameBookingsTextStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
TextStyle nameSiteBookingsTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: greyColor);
TextStyle startDateBookingsTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
TextStyle timeBookingsTextStyle = const TextStyle(fontSize: 14);

// Favourite screen style
TextStyle tabBarItemFavouriteBookingsTextStyle =
    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
TextStyle nameEquipmentFavoriteBookingsTextStyle =
    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
TextStyle levelAndTypeEquipmentFavoriteBookingsTextStyle =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
TextStyle nameMeetingRoomFavoriteBookingsTextStyle =
    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
TextStyle levelAndTypeMeetingRoomFavoriteBookingsTextStyle =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
// Details screen style
TextStyle titleDetailsTextStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
TextStyle contentDetailsTextStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

// New booking screen style
TextStyle tabBarItemNewBookingsTextStyle =
    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
TextStyle nameEquipmentNewBookingsTextStyle =
    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
TextStyle levelAndTypeEquipmentNewBookingsTextStyle =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
TextStyle nameMeetingRoomNewBookingsTextStyle =
    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
TextStyle levelAndTypeMeetingRoomNewBookingsTextStyle =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

// Edit booking screen style

TextStyle titleEditBookingTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: blackColor);
// TextStyle contentEditBookingTextStyle =
//     TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: blackColor);
TextStyle checkTimelineEditBookingTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: greenColor);

// Booking selectime screen style
TextStyle nameDetailsTextStyle() {
  return const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

TextStyle idDetailsTextStyle() {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
}

TextStyle levelAndSiteNameDetailsTextStyle() {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
}

TextStyle contentEditBookingTextStyle(Color? color) {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: color,
  );
}
