import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_flutter_dicoding/data/model/restaurant_detail.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_flutter_dicoding/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_flutter_dicoding/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_flutter_dicoding/screen/detail/restaurant_description_widget.dart';
import 'package:restaurant_flutter_dicoding/style/colors/restaurant_colors.dart';
import 'package:restaurant_flutter_dicoding/style/typography/restaurant_text_styles.dart';
import 'package:restaurant_flutter_dicoding/static/restaurant_detail_result_state.dart';
import 'package:restaurant_flutter_dicoding/screen/detail/favorite_icon_widget.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  final RestaurantDetail restaurant;

  const BodyOfDetailScreenWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Hero(
                tag: restaurant.id,
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}",
                  loadingBuilder: (_, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: Lottie.asset(
                        'assets/animations/loading_animation.json',
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) {
                    return Icon(
                      Icons.broken_image,
                      size: 50,
                      color: RestaurantColors.primary.color,
                    );
                  },
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    restaurant.name,
                    style: RestaurantTextStyles.headlineLarge,
                  ),
                ),
                ChangeNotifierProvider(
                  create: (context) => FavoriteIconProvider(),
                  child: Consumer<RestaurantDetailProvider>(
                      builder: (_, value, __) {
                    return switch (value.resultState) {
                      RestaurantDetailLoadedState(data: var restaurant) =>
                        FavoriteIconWidget(restaurant: restaurant),
                      _ => const SizedBox(),
                    };
                  }),
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: RestaurantColors.locationIcon.color,
                  size: 22,
                ),
                const SizedBox(width: 4.0),
                Text(
                  "${restaurant.city}, ${restaurant.address}",
                  style: RestaurantTextStyles.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: RestaurantColors.ratingIcon.color,
                  size: 22,
                ),
                const SizedBox(width: 4),
                Text(
                  restaurant.rating.toString(),
                  style: RestaurantTextStyles.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: RestaurantDescriptionWidget(
                  description: restaurant.description,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text("Categories:", style: RestaurantTextStyles.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: restaurant.categories.map((category) {
                return Chip(
                  backgroundColor: RestaurantColors.primary.color,
                  label: Text(
                    category.name,
                    style: RestaurantTextStyles.titleMedium
                        .copyWith(color: RestaurantColors.surface.color),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              "Menus:",
              style: RestaurantTextStyles.titleMedium,
            ),
            const SizedBox(height: 8),
            Text("Foods:", style: RestaurantTextStyles.titleSmall),
            const SizedBox(height: 8),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3 / 2,
              ),
              itemCount: restaurant.menus.foods.length,
              itemBuilder: (context, index) {
                final food = restaurant.menus.foods[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.fastfood,
                        size: 40,
                        color: RestaurantColors.primary.color,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        food.name,
                        textAlign: TextAlign.center,
                        style: RestaurantTextStyles.titleSmall,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Text("Drinks:", style: RestaurantTextStyles.titleSmall),
            const SizedBox(height: 8),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3 / 2,
              ),
              itemCount: restaurant.menus.drinks.length,
              itemBuilder: (context, index) {
                final drink = restaurant.menus.drinks[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.fastfood,
                        size: 40,
                        color: RestaurantColors.primary.color,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        drink.name,
                        textAlign: TextAlign.center,
                        style: RestaurantTextStyles.titleSmall,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              "Customer Reviews:",
              style: RestaurantTextStyles.titleMedium,
            ),
            const SizedBox(height: 8),
            ...restaurant.customerReviews.map((review) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: RestaurantColors.primary.color,
                      child: Icon(
                        Icons.person,
                        size: 28,
                        color: RestaurantColors.onPrimary.color,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(review.name,
                              style: RestaurantTextStyles.titleMedium),
                          const SizedBox(height: 4),
                          Text(review.date,
                              style: RestaurantTextStyles.labelSmall),
                          const SizedBox(height: 8),
                          Text(
                            review.review,
                            style: RestaurantTextStyles.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
