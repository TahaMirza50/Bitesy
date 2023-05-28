import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant_review_app/features/restaurant/data/models/restaurant_review_model.dart';
import 'package:uuid/uuid.dart';

import '../../domain/repostiories/write_a_review_repo.dart';

part 'write_a_review_event.dart';
part 'write_a_review_state.dart';

class WriteAReviewBloc extends Bloc<WriteAReviewEvent, WriteAReviewState> {
  static Uuid uuid = Uuid();
  WriteAReviewBloc() : super(WriteAReviewInitial()) {
    on<PostReviewEvent>(postReviewEvent);
  }

  FutureOr<void> postReviewEvent(
      PostReviewEvent event, Emitter<WriteAReviewState> emit) async {
    print("Post Review Event");
    emit(WriteAReviewLoadingState());

    RestaurantReviewModel review = RestaurantReviewModel(
      avatar: event.avatar,
      id: uuid.v4(),
      images: event.images != null ? event.images! : [],
      rating: event.rating,
      restaurantId: event.restaurantId,
      review: event.review,
      userId: event.userId,
      userName: event.userName,
    );
    // Call the API to post the review
    Response response =
        await WriteARestaurantReviewRepository.createRestaurantReview(review);

    if (response.status == 200) {
      Response response2 =
        await WriteARestaurantReviewRepository.updateRestaurantDetails(
            event.rating,
            event.restaurantId,
            event.numReviews,
            event.avgRating);
      if (response2.status == 200) {
        emit(NavigateToRestaurantHomeState());
      } else {
        emit(WriteAReviewErrorState(message: response2.message));
      }
    }
    else {
      emit(WriteAReviewErrorState(message: response.message));
    }
    // Call the API to update num_reviews and avg_rating
    
    // Navigate to Restaurant Home

    
  }
}
