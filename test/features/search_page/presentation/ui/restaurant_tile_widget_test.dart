import 'package:Bitesy/constants/constants.dart';
import 'package:Bitesy/features/search_page/data/model/restaurant_model.dart';
import 'package:Bitesy/features/search_page/presentation/bloc/search_page_bloc.dart';
import 'package:Bitesy/features/search_page/presentation/ui/restaurant_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockSearchPageBloc extends Mock implements SearchPageBloc {}

void main() {
  late MockSearchPageBloc mockSearchPageBloc;

  setUp(() {
    mockSearchPageBloc = MockSearchPageBloc();
  });

  group('Restaurant tile should render correctly.', () {
    testWidgets('restaurant tile widget ...', (tester) async {
      final RestaurantModel restaurantModel = RestaurantModel(
          id: Constants.IDGenerator.v1(),
          name: 'name',
          address: 'address',
          phoneNum: 'phoneNum',
          description: 'description',
          email: 'email',
          website: 'website',
          latitude: 'latitude',
          longitude: 'longitude',
          avgRating: "0.0",
          numReviews: 0,
          images: [''],
          ratingCounts: {'5': 0, '4': 0, '3': 0, '2': 0, '1': 0},
          menu: '');

      mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RestaurantTile(
                  restaurantBloc: mockSearchPageBloc,
                  restaurantModel: restaurantModel),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text(restaurantModel.name), findsOneWidget);
        expect(find.text(restaurantModel.address), findsOneWidget);
        expect(find.text(restaurantModel.numReviews.toString()), findsOneWidget);
        expect(find.byIcon(Icons.reviews), findsOneWidget);
      });

      // TODO: Implement test
    });
  });
}
