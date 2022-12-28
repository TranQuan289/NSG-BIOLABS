import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // log(event.runtimeType.toString());
    debugPrint('print ${bloc.runtimeType} -- onEvent ${event.runtimeType}');
  }
}
