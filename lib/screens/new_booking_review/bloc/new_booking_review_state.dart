part of 'new_booking_review_bloc.dart';

abstract class NewBookingReviewState {
  final EquipmentItem? equipmentItem;
  final MeetingRoomItem? meetingRoomItem;
  NewBookingReviewState({
    this.equipmentItem,
    this.meetingRoomItem,
  });
}

class NewBookingReviewInitial extends NewBookingReviewState {
  NewBookingReviewInitial({
    super.equipmentItem,
    super.meetingRoomItem,
  });
}


class NewBookingReviewSuccess extends NewBookingReviewState {
  NewBookingReviewSuccess({
    super.equipmentItem,
    super.meetingRoomItem,
  });
}

class NewBookingReviewError extends NewBookingReviewState {
  final String errorMessage;
  NewBookingReviewError({
    super.equipmentItem,
    super.meetingRoomItem,
    required this.errorMessage,
  });
}
