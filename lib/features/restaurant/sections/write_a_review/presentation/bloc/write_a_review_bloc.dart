import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:Bitesy/features/restaurant/data/models/restaurant_review_model.dart';
import 'package:uuid/uuid.dart';


import '../../../../../../screens/admin_page/ui/image_helper.dart';
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
    ResponseUser userResponse =
        await UserRepository.fetchUserByEmail(event.userEmail);
    final reviewId = uuid.v4();
    List<String> reviewImages = [];
    // uplaod Images to firebase storage

    if (event.images != null) {
      await Future.wait(event.images!.map((element) async {
        var url = await UploadImage(image: element).upLoadToFirebase(reviewId);
        reviewImages.add(url);
      }));
    }

    print("Review images $reviewImages");
    RestaurantReviewModel review = RestaurantReviewModel(
      // TODO: replace it with avatar from userResponse
      avatar: event.avatar,
      id: reviewId,
      images: reviewImages,
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
    } else {
      emit(WriteAReviewErrorState(message: response.message));
    }
  }
}
