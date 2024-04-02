part of 'recommendation_cubit.dart';

@immutable
sealed class RecommendationState {}

final class RecommendationInitial extends RecommendationState {}

final class RecommendationLoading extends RecommendationState {}

final class RecommendationFailure extends RecommendationState {
  final String msg;
  RecommendationFailure(this.msg);
}

final class RecommendationSuccess extends RecommendationState {
  final RecommendationResponse response;
  RecommendationSuccess(this.response);
}
