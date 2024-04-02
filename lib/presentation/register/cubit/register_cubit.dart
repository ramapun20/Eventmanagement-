import 'package:bloc/bloc.dart';
import 'package:event_buddy/models/user_response_model.dart';
import 'package:event_buddy/network/locator.dart';
import 'package:event_buddy/network/repository.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final Repository _repository = Repository(kClient);

  void register(Map<String, dynamic> data) async {
    emit(RegisterLoading());
    try {
      final UserResponse user = await _repository.register(data);
      if (user.status!) {
        emit(RegisterSuccess("Successfully registered"));
      } else {
        emit(RegisterFailure(user.status.toString()));
      }
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
