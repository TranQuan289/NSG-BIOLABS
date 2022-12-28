part of 'new_booking_review_bloc.dart';

abstract class NewBookingReviewEvent {}

class FetchDataBookingReviewEvent extends NewBookingReviewEvent {
  final EquipmentItem? equipmentItem;
  final MeetingRoomItem? meetingRoomItem;
  FetchDataBookingReviewEvent({
    this.equipmentItem,
    this.meetingRoomItem,
  });
}



class AddBookingEvent extends NewBookingReviewEvent {
  final DateTime fromDate;
  final DateTime toDate;
  final double fromTime;
  final double toTime;
  final int orderableId;
  final String orderableType;

  AddBookingEvent({
    required this.orderableId,
    required this.orderableType,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
  });
}
