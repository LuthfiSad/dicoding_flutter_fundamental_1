import 'package:restaurant_flutter_dicoding/data/model/restaurant.dart';

class RestaurantSearchResponse {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantSearchResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: json["restaurants"] != null
            ? List<Restaurant>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJson(x)))
            : <Restaurant>[]);
  }
}
