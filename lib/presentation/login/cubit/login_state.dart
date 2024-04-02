part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginFailure extends LoginState {
  final String msg;
  LoginFailure(this.msg);
}

final class LoginSuccess extends LoginState {
  final UserResponse user;
  LoginSuccess(this.user);
}
