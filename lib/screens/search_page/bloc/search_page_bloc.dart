import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:Bitesy/screens/login_and_signup/model/user.dart';
import 'package:Bitesy/screens/login_and_signup/repository/user_repository.dart';
import 'package:Bitesy/screens/search_page/model/restaurant_model.dart';
import 'package:Bitesy/screens/search_page/repository/restaurant_repo.dart';

part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  SearchPageBloc() : super(SearchPageInitialState()) {
    on<SearchPageInitialEvent>(searchPageInitialEvent);
    on<SearchButtonPressedEvent>(searchButtonPressedEvent);
    on<NavigateToRestaurantPageEvent>(navigateToRestaurantPageEvent);
  }

  FutureOr<void> searchPageInitialEvent(
      SearchPageInitialEvent event, Emitter<SearchPageState> emit) async {
    emit(SearchPageLoadingState());
    await Future.delayed(const Duration(seconds: 2));

    final ResponseUser responseUser = await UserRepository.fetchUserByEmail(
        FirebaseAuth.instance.currentUser!.email.toString());

    final Response response = await RestaurantRepository.fetchRestaurantList();

    if (response.status == 200 && responseUser.status == 200) {
      emit(
          SearchPageSuccessState(response.restaurantsList, responseUser.user));
    } else {
      emit(SearchPageErrorState(response.message));
    }
  }

  FutureOr<void> searchButtonPressedEvent(
      SearchButtonPressedEvent event, Emitter<SearchPageState> emit) async {
    emit(SearchPageLoadingState());
    await Future.delayed(const Duration(seconds: 2));

    final Response response =
        await RestaurantRepository.fetchRestaurantByNameAndRating(event.restaurantName,event.currentRating);

    final ResponseUser responseUser = await UserRepository.fetchUserByEmail(
        FirebaseAuth.instance.currentUser!.email.toString());
    if (response.status == 200 && responseUser.status == 200) {
      emit(SearchPageSuccessState(response.restaurantsList,responseUser.user));
    } else {
      emit(SearchPageErrorState(response.message));
    }
  }

  FutureOr<void> navigateToRestaurantPageEvent(
      NavigateToRestaurantPageEvent event, Emitter<SearchPageState> emit) {
    emit(NavigateToRestaurantPageState(event.restaurantModel));
  }
}
