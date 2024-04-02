part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterFailure extends RegisterState {
  final String msg;
  RegisterFailure(this.msg);
}

final class RegisterSuccess extends RegisterState {
  final String msg;
  RegisterSuccess(this.msg);
}
