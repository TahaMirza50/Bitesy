import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  SearchPageBloc() : super(SearchPageInitialState()) {
    on<SearchPageInitialEvent>(searchPageInitialEvent);
    on<SearchButtonPressedEvent>(searchButtonPressedEvent);
    on<NavigateToRestaurantPageEvent>(navigateToRestaurantPageEvent);
  }



  FutureOr<void> searchPageInitialEvent(SearchPageInitialEvent event, Emitter<SearchPageState> emit) async {
    emit(SearchPageLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(SearchPageSuccessState());
  }

  FutureOr<void> searchButtonPressedEvent(SearchButtonPressedEvent event, Emitter<SearchPageState> emit) {
  }

  FutureOr<void> navigateToRestaurantPageEvent(NavigateToRestaurantPageEvent event, Emitter<SearchPageState> emit) {
  }
}
