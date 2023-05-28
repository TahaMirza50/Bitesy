import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial()) {
    on<RestaurantInitialEvent>(restaurantInitialEvent);
  }

  FutureOr<void> restaurantInitialEvent(
      RestaurantInitialEvent event, Emitter<RestaurantState> emit) {}

}
