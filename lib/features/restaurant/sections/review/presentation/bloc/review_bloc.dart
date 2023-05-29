import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/restaurant_review_model.dart';
import '../../domain/repositories/restaurant_review_repo.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitial()) {
    on<ReviewInitialEvent>(reviewInitialEvent);
    on<NavigateToWriteAReviewEvent>(navigateToWriteAReviewEvent);
  }

  FutureOr<void> reviewInitialEvent(
      ReviewInitialEvent event, Emitter<ReviewState> emit) async {
    print("Review Initial Event");
    emit(ReviewLoadingState());
    Response response = await RestaurantReviewRepository.fetchRestaurantReviews(
        event.restaurantId);

    if (response.status == 200) {
      emit(ReviewSuccessState(reviews: response.reviewList));
    } else {
      emit(ReviewErrorState(message: response.message));
    }
  }

  FutureOr<void> navigateToWriteAReviewEvent(
      NavigateToWriteAReviewEvent event, Emitter<ReviewState> emit) {
    print("Naviaget to write a review");
    emit(NavigateToWriteAReviewActionState());
  }
}
