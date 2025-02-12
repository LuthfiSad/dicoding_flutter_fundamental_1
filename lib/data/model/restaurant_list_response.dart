import "package:restaurant_flutter_dicoding/data/model/restaurant.dart";

class RestaurantListResponse {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantListResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: json["restaurants"] != null
            ? List<Restaurant>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJson(x)))
            : <Restaurant>[]);
  }
}
