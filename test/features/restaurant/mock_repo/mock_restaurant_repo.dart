import 'package:Bitesy/features/restaurant/domain/repositories/restaurant_repo.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockRestaurantRepo extends Mock implements RestaurantRepository {
  static Future<Response> fetchRestaurant(String id) async {
    Response response = Response();
    Future.delayed(const Duration(seconds: 2));
    try {
      response.restaurantModel = mockRepoItemData;
      response.status = 200;
      response.message = "Restaurant read successfully";
    } catch (error) {
      response.status = 400;
      response.message = error.toString();
    }

    return await Future.value(response);
  }
}
