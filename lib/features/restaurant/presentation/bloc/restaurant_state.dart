part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();
  
  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoadingState extends RestaurantState {}

class RestaurantSuccessState extends  RestaurantState {
  final RestaurantModel restaurant;

  const RestaurantSuccessState({required this.restaurant});
}

class RestaurantErrorState extends RestaurantState {
  final String message;

  const RestaurantErrorState({required this.message});
}