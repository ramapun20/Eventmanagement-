part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileFailure extends ProfileState {
  final String msg;
  ProfileFailure(
    this.msg,
  );
}

final class ProfileSuccess extends ProfileState {
  final UserResponse user;
  ProfileSuccess(this.user);
}
