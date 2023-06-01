import 'package:Bitesy/features/login_and_signup/data/model/user.dart';
import 'package:Bitesy/features/search_page/presentation/bloc/search_page_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';


void main() {
  group('Search Bloc', () {
    late SearchPageBloc searchPageBloc = SearchPageBloc();
    late UserModel userModel;

    test('should inital state be SearchPageInitialState', () {
      expect(searchPageBloc.state, searchPageInitialState);
    });

    blocTest(
      'should first state be SearchPageLoadingState when SearchPageInitialEvent is added.',
      build: () => searchPageBloc,
      act: (bloc) async {
        bloc.add(SearchPageInitialEvent());
      },
      expect: () => 
          [isA<SearchPageLoadingState>()],
    );
  });
}

const searchPageInitialState = TypeMatcher<SearchPageInitialState>();
const searchPageLoadingState = TypeMatcher<SearchPageLoadingState>();
