import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:domain/models/bookings/ongoing_booking_model.dart';
import 'package:domain/models/bookings/upcoming_booking_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../index.dart';

part 'home_booking_event.dart';
part 'home_booking_state.dart';

class HomeBookingBloc extends Bloc<HomeBookingEvent, HomeBookingState> {
  RefreshController refreshController = RefreshController();
  HomeBookingRepository homeBookingRepository;
  int pageUpcoming = 1;
  HomeBookingBloc(this.homeBookingRepository) : super(HomeBookingInitial()) {
    on<FetchDataHomeBookingEvent>(_onFetchDataUpcomingBookingEvent);
    on<RefreshUpcomingBookingEvent>(_onRefreshUpcomingBookingEvent);
    on<LoadMoreUpcomingBookingEvent>(_onLoadMoreUpcomingBookingEvent);
  }
  FutureOr<void> _onFetchDataUpcomingBookingEvent(
      FetchDataHomeBookingEvent event, Emitter<HomeBookingState> emit) async {
    try {
      var ongoingResult = await homeBookingRepository.getOngoingBookings();

      var upcomingResult = await homeBookingRepository.getUpcomingBookings(
        page: pageUpcoming,
        perPage: 10,
      );
      emit(
        HomeBookingSucess(
          listUpcomingBooking: upcomingResult.list,
          listOngoingBooking: ongoingResult.list,
        ),
      );
    } catch (e) {
      emit(HomeBookingError(errorMessage: e.toString()));
    }
  }

  @override
  void onEvent(HomeBookingEvent event) {
    log(event.runtimeType.toString());
    super.onEvent(event);
  }

  FutureOr<void> _onRefreshUpcomingBookingEvent(
      RefreshUpcomingBookingEvent event, Emitter<HomeBookingState> emit) async {
    try {
      await Future.delayed(
        const Duration(seconds: 1),
        () => refreshController.refreshCompleted(),
      ).then(
        (value) async {
          pageUpcoming = 1;
          var upcomingResult = await homeBookingRepository.getUpcomingBookings(
            page: pageUpcoming,
            perPage: 10,
          );
          emit(
            HomeBookingSucess(
              listOngoingBooking: (state as HomeBookingSucess).listOngoingBooking,
              listUpcomingBooking: upcomingResult.list,
            ),
          );
        },
      );
    } catch (e) {
      emit(HomeBookingError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onLoadMoreUpcomingBookingEvent(
      LoadMoreUpcomingBookingEvent event, Emitter<HomeBookingState> emit) async {
    try {
      var curentListUpcoming = (state as HomeBookingSucess).listUpcomingBooking;
      pageUpcoming += 1;
      var upcomingResult = await homeBookingRepository.getUpcomingBookings(
        page: pageUpcoming,
        perPage: 10,
      );
      await Future.delayed(const Duration(seconds: 1));
      if (upcomingResult.list.isEmpty) {
        refreshController.loadFailed();
      } else {
        var newListUpcoming = List<UpcomingBooking>.from(curentListUpcoming)
          ..addAll(upcomingResult.list);
        refreshController.loadComplete();
        emit(
          HomeBookingSucess(
            listOngoingBooking: (state as HomeBookingSucess).listOngoingBooking,
            listUpcomingBooking: newListUpcoming,
          ),
        );
      }
    } catch (e) {
      emit(HomeBookingError(errorMessage: e.toString()));
    }
  }
}
