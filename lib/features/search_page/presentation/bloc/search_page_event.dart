part of 'search_page_bloc.dart';

@immutable
abstract class SearchPageEvent {}

class SearchPageInitialEvent extends SearchPageEvent {}

class SearchButtonPressedEvent extends SearchPageEvent {
  final String restaurantName;
  final String currentRating;
  SearchButtonPressedEvent(this.restaurantName,this.currentRating);
}

class NavigateToRestaurantPageEvent extends SearchPageEvent {
  final RestaurantModel restaurantModel;
  NavigateToRestaurantPageEvent(this.restaurantModel);
}

