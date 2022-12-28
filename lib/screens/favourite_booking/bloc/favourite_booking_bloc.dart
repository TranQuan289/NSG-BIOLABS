import 'package:bloc/bloc.dart';

part 'favourite_booking_event.dart';
part 'favourite_booking_state.dart';

class FavouriteBookingBloc extends Bloc<FavouriteBookingEvent, FavouriteBookingState> {
  FavouriteBookingBloc() : super(FavouriteBookingInitial()) {
    on<FavouriteBookingEvent>((event, emit) {});
  }
}
