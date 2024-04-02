import 'package:bloc/bloc.dart';
import 'package:event_buddy/network/locator.dart';
import 'package:event_buddy/network/repository.dart';
import 'package:meta/meta.dart';

part 'apply_event_state.dart';

class ApplyEventCubit extends Cubit<ApplyEventState> {
  ApplyEventCubit() : super(ApplyEventInitial());

  final Repository repo = Repository(kClient);

  void applyEvent(String jobID) async {
    emit(ApplyEventLoading());
    final resp = await repo.applyEvent({"job": jobID});
    if (resp.statusCode == 200) {
      emit(ApplyEventSuccess(resp.data['msg']));
    } else {
      emit(ApplyEventFailure(resp.data['msg']));
    }
  }
}
