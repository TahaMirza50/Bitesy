part of 'search_page_bloc.dart';

@immutable
abstract class SearchPageState {}

abstract class SearchPageActionState extends SearchPageState {
}

class SearchPageInitialState extends SearchPageState {}

class SearchPageLoadingState extends SearchPageState {}

class SearchPageSuccessState extends SearchPageState {
  final List<RestaurantModel> restaurants;
  SearchPageSuccessState(this.restaurants);
}

class SearchPageErrorState extends SearchPageState {
  final String error;
  SearchPageErrorState(this.error);
}

class NavigateToRestaurantPageState extends SearchPageActionState {
  final RestaurantModel restaurantModel;
  NavigateToRestaurantPageState(this.restaurantModel);
}
