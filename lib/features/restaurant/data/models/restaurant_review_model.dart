import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantReviewModel {
  final String id;
  final String restaurantId;
  final String userId;
  final String userName;
  final String userEmail;
  final String avatar;
  final String review;
  final int rating;
  final Timestamp timestamp;
  final int reportCount;
  final List<String> reportList;
  final List<String> images;

  RestaurantReviewModel(
      {required this.id,
      required this.restaurantId,
      required this.userId,
      required this.userName,
      required this.userEmail,
      required this.avatar,
      required this.review,
      required this.rating,
      required this.timestamp,
      this.reportCount = 0,
      this.reportList = const [],
      required this.images});

  static RestaurantReviewModel fromJson(Map<String, dynamic> json) {
    return RestaurantReviewModel(
        id: json['id'] as String? ?? "field empty",
        restaurantId: json['restaurantId'] as String? ?? "field empty",
        userId: json['userId'] as String? ?? "field empty",
        userName: json['userName'] as String? ?? "field empty",
        userEmail: json['userEmail'] as String? ?? "field empty",
        avatar: json['avatar'] as String? ?? "field empty",
        review: json['review'] as String? ?? "field empty",
        rating: json['rating'] as int? ?? 0,
        timestamp: json['timestamp'] as Timestamp? ?? Timestamp.now(),
        reportCount: json['reportCount'] as int? ?? 0,
        reportList: List<String>.from(json['reportList'] ?? []),
        images: List<String>.from(json['images'] ?? []));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'avatar': avatar,
      'review': review,
      'rating': rating,
      'images': images,
      'reportCount': reportCount,
      'reportList': reportList,
      'timestamp': timestamp,
    };
  }
}
