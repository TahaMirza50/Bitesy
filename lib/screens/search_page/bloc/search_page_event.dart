part of 'search_page_bloc.dart';

@immutable
abstract class SearchPageEvent {}

class SearchPageInitialEvent extends SearchPageEvent {}

class SearchButtonPressedEvent extends SearchPageEvent {}

class NavigateToRestaurantPageEvent extends SearchPageEvent {}

