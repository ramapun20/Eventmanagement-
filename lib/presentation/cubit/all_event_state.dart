part of 'all_event_cubit.dart';

@immutable
sealed class AllEventState {}

final class AllEventInitial extends AllEventState {}

final class AllEventLoading extends AllEventState {}

final class AllEventFailure extends AllEventState {
  final String msg;
  AllEventFailure(this.msg);
}

final class AllEventSuccess extends AllEventState {
  final AllEventsResponse data;
  AllEventSuccess(this.data);
}


