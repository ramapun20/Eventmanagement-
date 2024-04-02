import 'package:bloc/bloc.dart';
import 'package:event_buddy/models/recommendation_response.dart';
import 'package:event_buddy/network/locator.dart';
import 'package:event_buddy/network/repository.dart';
import 'package:meta/meta.dart';

part 'recommendation_state.dart';

class RecommendationCubit extends Cubit<RecommendationState> {
  RecommendationCubit() : super(RecommendationInitial()) {
    getRecommendation();
  }
  final Repository repo = Repository(kClient);

  void getRecommendation() async {
    emit(RecommendationLoading());
    var resp = await repo.getRecommendation();
    if (resp.success!) {
      emit(RecommendationSuccess(resp));
    } else {
      emit(RecommendationFailure("Failed to get recommendations"));
    }
  }
}
