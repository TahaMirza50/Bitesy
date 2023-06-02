import 'package:Bitesy/features/search_page/data/model/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RestaurantModel Tests', () {
    test('Create RestaurantModel instance from JSON', () {
      Map<String, dynamic> json = {
        'id': '1',
        'name': 'Restaurant ABC',
        'address': '123 Main Street',
        'phoneNum': '123-456-7890',
        'description': 'A lovely restaurant',
        'email': 'info@restaurantabc.com',
        'website': 'www.restaurantabc.com',
        'latitude': '40.7128',
        'longitude': '-74.0060',
        'avgRating': '4.5',
        'numReviews': 10,
        'ratingCounts': {
          '5': 4,
          '4': 3,
          '3': 2,
          '2': 1,
          '1': 0,
        },
        'images': ['', '', ''],
        'menu': '',
      };

      RestaurantModel restaurant = RestaurantModel.fromJson(json);

      expect(restaurant.id, '1');
      expect(restaurant.name, 'Restaurant ABC');
      expect(restaurant.address, '123 Main Street');
      expect(restaurant.phoneNum, '123-456-7890');
      expect(restaurant.description, 'A lovely restaurant');
      expect(restaurant.email, 'info@restaurantabc.com');
      expect(restaurant.website, 'www.restaurantabc.com');
      expect(restaurant.latitude, '40.7128');
      expect(restaurant.longitude, '-74.0060');
      expect(restaurant.avgRating, '4.5');
      expect(restaurant.numReviews, 10);
      expect(restaurant.ratingCounts, {
        '5': 4,
        '4': 3,
        '3': 2,
        '2': 1,
        '1': 0,
      });
      expect(restaurant.images, ['', '', '']);
      expect(restaurant.menu, '');
    });

    test('Create JSON from RestaurantModel instance', () {
      RestaurantModel restaurant = RestaurantModel(
        id: '1',
        name: 'Restaurant ABC',
        address: '123 Main Street',
        phoneNum: '123-456-7890',
        description: 'A lovely restaurant',
        email: 'info@restaurantabc.com',
        website: 'www.restaurantabc.com',
        latitude: '40.7128',
        longitude: '-74.0060',
        avgRating: '4.5',
        numReviews: 10,
        ratingCounts: {
          '5': 4,
          '4': 3,
          '3': 2,
          '2': 1,
          '1': 0,
        },
        images: ['', '', ''],
        menu: '',
      );

      Map<String, dynamic> json = restaurant.toJson();

      expect(json['id'], '1');
      expect(json['name'], 'Restaurant ABC');
      expect(json['address'], '123 Main Street');
      expect(json['phoneNum'], '123-456-7890');
      expect(json['description'], 'A lovely restaurant');
      expect(json['email'], 'info@restaurantabc.com');
      expect(json['website'], 'www.restaurantabc.com');
      expect(json['latitude'], '40.7128');
      expect(json['longitude'], '-74.0060');
      expect(json['avgRating'], '4.5');
      expect(json['numReviews'], 10);
      expect(json['ratingCounts'], {
        '5': 4,
        '4': 3,
        '3': 2,
        '2': 1,
        '1': 0,
      });
      expect(json['images'], ['', '', '']);
      expect(json['menu'], '');
    });
  });
}
