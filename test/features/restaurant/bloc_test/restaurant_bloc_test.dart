import 'package:Bitesy/features/restaurant/domain/repositories/restaurant_repo.dart';
import 'package:Bitesy/features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'package:Bitesy/features/search_page/data/model/restaurant_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_repo/mock_data.dart';
import '../mock_repo/mock_restaurant_repo.dart';


void main() {
  group('RestaurantBloc', () {
    late RestaurantRepository restaurantRepository;
    late RestaurantModel restaurantModel;

    setUpAll(() {
      // restaurantRepository = MockRestaurantRepo();
      restaurantModel = mockRepoItemData;
    });

    blocTest(
      'emits [RestaurantLoadingState, RestaurantSuccessState] when RestaurantInitialEvent is added',
      build: () {
        when(() => MockRestaurantRepo.fetchRestaurant("1"))
            .thenAnswer((_) async => Response(status: 200, restaurantModel: restaurantModel));
        return RestaurantBloc();
      },
      act: (bloc) => bloc.add(RestaurantInitialEvent(id: '1')),
      expect: () => [
        RestaurantLoadingState(),
        RestaurantSuccessState(restaurant: restaurantModel),
      ],
    );

    blocTest<RestaurantBloc, RestaurantState>('emits [RestaurantLoadingState, RestaurantErrorState] when RestaurantInitialEvent is added and fetchRestaurant returns an error',
      build: () {
        when(() => MockRestaurantRepo.fetchRestaurant('1'))
            .thenAnswer((_) async => Response(status: 400, message: 'Restaurant not found'));
        return RestaurantBloc();
      },
      act: (bloc) => bloc.add(RestaurantInitialEvent(id: '1')),
      expect: () => [
        RestaurantLoadingState(),
        RestaurantErrorState(message: 'Error'),
      ],
    );
  });
}