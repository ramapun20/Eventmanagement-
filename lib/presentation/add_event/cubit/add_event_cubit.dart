import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:event_buddy/network/locator.dart';
import 'package:event_buddy/network/repository.dart';
import 'package:meta/meta.dart';

part 'add_event_state.dart';

class AddEventCubit extends Cubit<AddEventState> {
  AddEventCubit() : super(AddEventInitial());

  final Repository repo = Repository(kClient);

  void addEvent(Map<String, dynamic> data) async {
    emit(AddEventLoading());
    // log(data.toString());
    var resp = await repo.addEvent(data);
    if (resp.data["success"]) {
      emit(AddEventSuccess("Successfully added"));
    } else {
      emit(AddEventFailure("Failed to add event"));
    }
  }
}
