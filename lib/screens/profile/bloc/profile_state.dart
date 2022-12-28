part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ChangeProfileSuccess extends ProfileState {}

class ProfileErorr extends ProfileState {}
