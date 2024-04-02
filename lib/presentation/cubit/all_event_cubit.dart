import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:event_buddy/models/all_events_response.dart';
import 'package:event_buddy/network/locator.dart';
import 'package:event_buddy/network/repository.dart';
import 'package:meta/meta.dart';

part 'all_event_state.dart';

class AllEventCubit extends Cubit<AllEventState> {
  AllEventCubit() : super(AllEventInitial()) {
    getEvents();
  }
  final Repository repo = Repository(kClient);

  void getEvents() async {
    emit(AllEventLoading());
    final resp = await repo.getEvents();
    if (resp.success!) {
      emit(AllEventSuccess(resp));
    } else {
      emit(AllEventFailure("Failed to get events"));
    }
  }

}
