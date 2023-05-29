part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

abstract class ReviewActionEvent extends ReviewEvent {
  const ReviewActionEvent();
}

class ReviewInitialEvent extends ReviewEvent {
  final String restaurantId;
  const ReviewInitialEvent({required this.restaurantId});
}


class NavigateToWriteAReviewEvent extends ReviewActionEvent {
  const NavigateToWriteAReviewEvent();
}
