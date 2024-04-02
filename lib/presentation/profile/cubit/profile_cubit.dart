import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:event_buddy/models/user_response_model.dart';
import 'package:event_buddy/network/locator.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    loadUserProfile();
  }

  void loadUserProfile() async {
    emit(ProfileLoading());
    var userData = await kPref.getUser();
    var user = UserResponse.fromJson(json.decode(userData!));
    if (user.status != null) {
      emit(ProfileSuccess(user));
    } else {
      emit(ProfileFailure("Failed to get profile"));
    }
  }
}
