part of 'add_event_cubit.dart';

@immutable
sealed class AddEventState {}

final class AddEventInitial extends AddEventState {}

final class AddEventLoading extends AddEventState {}

final class AddEventFailure extends AddEventState {
  final String msg;
  AddEventFailure(this.msg);
}

final class AddEventSuccess extends AddEventState {
  final String msg;
  AddEventSuccess(this.msg);
}
