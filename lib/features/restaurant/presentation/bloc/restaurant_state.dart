part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();
  
  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoadingState extends RestaurantState {}

class RestaurantSuccessState extends  RestaurantState {}

class RestaurantErrorState extends RestaurantState {}

class ReviewLoadingState extends RestaurantState {}

class ReviewSuccessState extends RestaurantState {}

class ReviewErrorState extends RestaurantState {}
