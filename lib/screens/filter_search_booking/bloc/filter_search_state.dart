part of 'filter_search_bloc.dart';

abstract class FilterSearchState {}

class FilterSearchInitial extends FilterSearchState {}

class FilterSearchSuccess extends FilterSearchState {
  List<int>? responseLevel;
  List<Site>? responseSite;
  FilterSearchSuccess({required this.responseLevel, required this.responseSite});
}

class FilterSearchFail extends FilterSearchState {}
