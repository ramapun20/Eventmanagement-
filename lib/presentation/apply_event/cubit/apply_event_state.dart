part of 'apply_event_cubit.dart';

@immutable
sealed class ApplyEventState {}

final class ApplyEventInitial extends ApplyEventState {}

final class ApplyEventLoading extends ApplyEventState {}

final class ApplyEventFailure extends ApplyEventState {
  final String msg;
  ApplyEventFailure(this.msg);
}

final class ApplyEventSuccess extends ApplyEventState {
  final String msg;
  ApplyEventSuccess(this.msg);
}
