part of 'search_page_bloc.dart';

@immutable
abstract class SearchPageState {}

abstract class SearchPageActionState extends SearchPageState {}

class SearchPageInitialState extends SearchPageState {}

class SearchPageLoadingState extends SearchPageState {}

class SearchPageSuccessState extends SearchPageState {}

class SearchPageErrorState extends SearchPageState {}

class NavigateToRestaurantPageState extends SearchPageActionState {}


