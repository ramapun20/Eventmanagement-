import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:event_buddy/models/user_response_model.dart';
import 'package:event_buddy/network/locator.dart';
import 'package:event_buddy/network/repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final Repository _repository = Repository(kClient);

  void login(String username, password) async {
    emit(LoginLoading());
    try {
      final UserResponse user = await _repository.login(username, password);
      if (user.status!) {
        kPref.saveUser(json.encode(user.toJson()));
        kPref.saveAccessToken(user.token ?? "");
        emit(LoginSuccess(user));
      } else {
        emit(LoginFailure(user.status.toString()));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
