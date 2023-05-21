class RestaurantModel{
  
  final String id;
  final String name;
  final String address;
  final int phoneNum;
  final String description;
  final String email;
  final String website;

  final String avgRating;
  final int numReviews;
  final String openHours;

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
    required this.openHours,
    required this.images
  });

  static RestaurantModel fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
            id: json['id'] as String? ?? "field empty" ,
            name: json['name'] as String? ?? "field empty",
            address: json['address'] as String? ?? "field empty",
            phoneNum: json['phoneNum'] as int? ?? 0,
            description: json['description'] as String? ?? "field empty",
            email: json['email'] as String? ?? "field empty",
            website: json['website'] as String? ?? "field empty",
            avgRating: json['avgRating'] as String? ?? "0.0",
            numReviews: json['numReviews'] as int? ?? 0,
            openHours: json['openHours'] as String? ?? "field empty",
            images: List<String>.from(json['images'] ?? []));
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
            'openHours': openHours,
            'images': images,
    };
  }

}