import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../screens/search_page/model/restaurant_model.dart';
import '../../domain/repositories/restaurant_repo.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial()) {
    on<RestaurantInitialEvent>(restaurantInitialEvent);
  }

  FutureOr<void> restaurantInitialEvent(
      RestaurantInitialEvent event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoadingState());

    final Response response =
        await RestaurantRepository.fetchRestaurant(event.id);

    if (response.status == 200) {
      emit(RestaurantSuccessState(restaurant: response.restaurantModel!));
    } else {
      emit(RestaurantErrorState(message: response.message));
    }
  }
}
