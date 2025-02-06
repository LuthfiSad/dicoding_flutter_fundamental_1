import 'package:restaurant_flutter_dicoding/data/model/restaurant_review.dart';

sealed class RestaurantReviewResultState {}

class RestaurantReviewNoneState extends RestaurantReviewResultState {}

class RestaurantReviewLoadingState extends RestaurantReviewResultState {}

class RestaurantReviewErrorState extends RestaurantReviewResultState {
  final String error;

  RestaurantReviewErrorState(this.error);
}

class RestaurantReviewLoadedState extends RestaurantReviewResultState {
  final List<RestaurantReview> data;

  RestaurantReviewLoadedState(this.data);
}
