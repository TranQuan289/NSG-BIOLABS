part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class FetchDataProfileEvent extends ProfileEvent {}

class ChangeImage extends ProfileEvent {
  final int choice;
  ChangeImage(this.choice);
}

class ChangeProfile extends ProfileEvent {

  final String? name;
  final String? role;
  final String? phoneNumber;
  ChangeProfile(
      { required this.name, required this.role, required this.phoneNumber});
}
