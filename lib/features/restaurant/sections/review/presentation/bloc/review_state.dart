part of 'review_bloc.dart';

abstract class ReviewState {}

abstract class ReviewActionState extends ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoadingState extends ReviewState {}

class ReviewSuccessState extends ReviewState {
  final List<RestaurantReviewModel> reviews;

  ReviewSuccessState({required this.reviews});
}

class ReviewErrorState extends ReviewState {
  final String message;

  ReviewErrorState({required this.message});
}

class ReviewReportLoadingState extends ReviewState {}

class ReviewReportSuccessState extends ReviewState {}
class NavigateToWriteAReviewActionState extends ReviewActionState {}
