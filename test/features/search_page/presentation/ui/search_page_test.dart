import 'package:Bitesy/features/search_page/presentation/bloc/search_page_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Search Bloc', () {
    late SearchPageBloc searchPageBloc = SearchPageBloc();
    
    setUp(() {
      searchPageBloc = SearchPageBloc();
    });

    tearDown(() {
      searchPageBloc.close();
    });

    test('should inital state be SearchPageInitialState', () {
      expect(searchPageBloc.state, searchPageInitialState);
    });

    blocTest(
      'should first state be SearchPageLoadingState when SearchPageInitialEvent is added.',
      build: () => searchPageBloc,
      act: (bloc) {
        bloc.add(SearchPageInitialEvent());
      },
      expect: () => [
        isA<SearchPageLoadingState>(),
      ],
    );
  });
}

const searchPageInitialState = TypeMatcher<SearchPageInitialState>();
