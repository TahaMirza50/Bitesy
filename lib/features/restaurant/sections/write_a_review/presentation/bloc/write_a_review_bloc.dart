import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant_review_app/features/restaurant/data/models/restaurant_review_model.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../screens/login_and_signup/repository/user_repository.dart';
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

    // fetch user details using email
    ResponseUser userResponse = await UserRepository.fetchUserByEmail(event.userEmail);

    RestaurantReviewModel review = RestaurantReviewModel(
      // TODO: replace it with avatar from userResponse
      avatar: event.avatar,
      id: uuid.v4(),
      images: event.images != null ? event.images! : [],
      rating: event.rating,
      restaurantId: event.restaurantId,
      review: event.review,
      userId: event.userId,
      userName: userResponse.user.firstName,
      timestamp: Timestamp.now(),
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
  }
}
