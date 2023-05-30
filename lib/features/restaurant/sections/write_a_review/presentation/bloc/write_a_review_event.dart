part of 'write_a_review_bloc.dart';

abstract class WriteAReviewEvent extends Equatable {
  const WriteAReviewEvent();

  @override
  List<Object> get props => [];
}

class PostReviewEvent extends WriteAReviewEvent {
  final String review;
  final int rating;
  final String restaurantId;
  final String userId;
  final String userEmail;
  final int numReviews;
  final String avgRating;
  final List<File>? images;

  const PostReviewEvent(
    {
    required this.numReviews,
    required this.avgRating,
    required this.review,
    required this.rating,
    required this.restaurantId,
    required this.userId,
    required this.userEmail,
    this.images,
  }
  );
}
