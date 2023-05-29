part of 'write_a_review_bloc.dart';

abstract class WriteAReviewState extends Equatable {
  const WriteAReviewState();
  
  @override
  List<Object> get props => [];
}

abstract class WriteAReviewActionState extends WriteAReviewState {
  const WriteAReviewActionState();
}

class WriteAReviewInitial extends WriteAReviewState {}

class WriteAReviewLoadingState extends WriteAReviewState {}
class WriteAReviewErrorState extends WriteAReviewState {
  final String message;

  const WriteAReviewErrorState({required this.message});
}
class NavigateToRestaurantHomeState extends WriteAReviewActionState {}
