import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.profileReponstory) : super(ProfileInitial()) {
    on<FetchDataProfileEvent>(_onFetchDataProfileEvent);
    on<ChangeImage>(_onChangeImage);
    on<ChangeProfile>(_onChangeProfile);
  }

  ProfileReponstory profileReponstory;
  TextEditingController nameCotroller = TextEditingController();
  TextEditingController emailCotroller = TextEditingController();
  TextEditingController companyCotroller = TextEditingController();
  TextEditingController roleCotroller = TextEditingController();
  TextEditingController phoneCotroller = TextEditingController();

  String? avatar;

  File? img;

  _onFetchDataProfileEvent(FetchDataProfileEvent event, Emitter<ProfileState> emit) async {
    final response = await profileReponstory.getProfile();
    nameCotroller = TextEditingController(text: response.object.fullName);
    emailCotroller = TextEditingController(text: response.object.email);
    companyCotroller = TextEditingController(text: response.object.company?.name);
    roleCotroller = TextEditingController(text: response.object.role);
    phoneCotroller = TextEditingController(text: response.object.phoneNumber);
    avatar = response.object.avatar;
    emit(ProfileSuccess());
  }

  _onChangeImage(ChangeImage event, Emitter<ProfileState> emit) async {
    try {
      if (event.choice == 0) {
        final image = await ImagePicker().pickImage(source: ImageSource.camera);
        if (image == null) return;
        img = File(image.path);
      } else {
        final image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        img = File(image.path);
      }
      emit(ProfileSuccess());
    } catch (_) {}
  }

  _onChangeProfile(ChangeProfile event, Emitter<ProfileState> emit) async {
    final response =
        await profileReponstory.changeProfile(event.name, event.role, event.phoneNumber?? '');
    avatar = response.object.avatar;
    nameCotroller = TextEditingController(text: response.object.fullName);
    roleCotroller = TextEditingController(text: response.object.role);
    phoneCotroller = TextEditingController(text: response.object.phoneNumber);
    emit(ChangeProfileSuccess());
    emit(ProfileSuccess());
  }
}
