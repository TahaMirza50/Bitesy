part of 'search_page_bloc.dart';

@immutable
abstract class SearchPageEvent {}

class SearchPageInitialEvent extends SearchPageEvent {}

class SearchButtonPressedEvent extends SearchPageEvent {
  final String restaurantName;
  SearchButtonPressedEvent(this.restaurantName);
}

class NavigateToRestaurantPageEvent extends SearchPageEvent {
  final RestaurantModel restaurantModel;
  NavigateToRestaurantPageEvent(this.restaurantModel);
}

