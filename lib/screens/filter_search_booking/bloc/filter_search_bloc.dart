import 'package:bloc/bloc.dart';
import 'package:codebase/screens/filter_search_booking/filter_search_booking_repository.dart';
import 'package:domain/models/site.dart';
import 'package:flutter/material.dart';

part 'filter_search_event.dart';
part 'filter_search_state.dart';

class FilterSearchBloc extends Bloc<FilterSearchEvent, FilterSearchState> {
  FilterSearchBloc(this.filterSearchBookingRepository) : super(FilterSearchInitial()) {
    on<FetchDataFilterEvent>(_onFetchDataFilter);
  }
  FilterSearchBookingRepository filterSearchBookingRepository;
  ScrollController scrollController = ScrollController();
  ScrollPhysics physics = const RangeMaintainingScrollPhysics();
  List<bool?> isCheckedLevel = List.generate(2, (index) => false);
  List<bool?> isCheckedRoom = List.generate(8, (index) => false);
  bool isCheck = false;

  _onFetchDataFilter(FetchDataFilterEvent event, Emitter<FilterSearchState> emit) async {
    final response = await filterSearchBookingRepository.getFilter();
    emit(FilterSearchSuccess(
        responseLevel: response.object.levels, responseSite: response.object.sites));
  }
}
