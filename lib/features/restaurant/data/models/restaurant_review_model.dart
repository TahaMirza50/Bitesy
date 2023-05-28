class RestaurantReviewModel {
  final String id;
  final String restaurantId;
  final String userId;
  final String userName;
  final String avatar;
  final String review;
  final int rating;
  final List<String> images;

  RestaurantReviewModel(
      {required this.id,
      required this.restaurantId,
      required this.userId,
      required this.userName,
      required this.avatar,
      required this.review,
      required this.rating,
      required this.images});

  static RestaurantReviewModel fromJson(Map<String, dynamic> json) {
    return RestaurantReviewModel(
        id: json['id'] as String? ?? "field empty",
        restaurantId: json['restaurantId'] as String? ?? "field empty",
        userId: json['userId'] as String? ?? "field empty",
        userName: json['userName'] as String? ?? "field empty",
        avatar: json['avatar'] as String? ?? "field empty",
        review: json['review'] as String? ?? "field empty",
        rating: json['rating'] as int? ?? 0,
        images: List<String>.from(json['images'] ?? []));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'userId': userId,
      'userName': userName,
      'avatar': avatar,
      'review': review,
      'rating': rating,
      'images': images,
    };
  }
}
