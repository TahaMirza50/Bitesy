class RestaurantModel{
  
  final String id;
  final String name;
  final String address;
  final String phoneNum;
  final String description;
  final String email;
  final String website;

  final String avgRating;
  final String menu;
  final int numReviews;

  final List<String> images;


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
    required this.images,
    required this.menu
  });

  static RestaurantModel fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
            id: json['id'] as String? ?? "field empty" ,
            name: json['name'] as String? ?? "field empty",
            address: json['address'] as String? ?? "field empty",
            phoneNum: json['phoneNum'] as String? ?? "field empty",
            description: json['description'] as String? ?? "field empty",
            email: json['email'] as String? ?? "field empty",
            website: json['website'] as String? ?? "field empty",
            avgRating: json['avgRating'] as String? ?? "0.0",
            numReviews: json['numReviews'] as int? ?? 0,
            images: List<String>.from(json['images'] ?? [],),
            menu: json['menu'] as String? ?? "field empty");
  }

  Map<String, dynamic> toJson() {
    return {
            'id': id,
            'name': name,
            'address': address,
            'phoneNum': phoneNum,
            'description': description,
            'email': email,
            'website': website,
            'avgRating': avgRating,
            'numReviews': numReviews,
            'images': images,
            'menu':menu
    };
  }

}