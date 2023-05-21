class RestaurantModel{
  
  final String id;
  final String name;
  final String address;
  final double phoneNum;
  final String description;
  final String email;
  final String website;

  final double avgRating;
  final double numReviews;
  final String openHours;

  final List<String> images;
  final List<String> menu;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNum,
    required this.description,
    required this.email,
    required this.website,
    required this.avgRating,
    required this.numReviews,
    required this.openHours,
    required this.images,
    required this.menu
  });


}