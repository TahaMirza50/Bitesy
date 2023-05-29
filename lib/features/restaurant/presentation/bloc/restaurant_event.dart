part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

abstract class RestaurantActionEvent extends RestaurantEvent {
  const RestaurantActionEvent();
}

class RestaurantInitialEvent extends RestaurantEvent {
  final String id;
  const RestaurantInitialEvent({required this.id});
}