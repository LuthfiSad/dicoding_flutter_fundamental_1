import 'package:flutter/material.dart';
import 'package:restaurant_flutter_dicoding/static/navigation_route.dart';
import 'package:restaurant_flutter_dicoding/style/colors/restaurant_colors.dart';
import 'package:restaurant_flutter_dicoding/style/typography/restaurant_text_styles.dart';

class HomeAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Icon(
            Icons.restaurant_rounded,
            color: RestaurantColors.onPrimary.color,
            size: RestaurantTextStyles.headlineMedium.fontSize,
          ),
          const SizedBox(width: 12),
          Text(
            "Restaurant",
            style: RestaurantTextStyles.headlineSmall.copyWith(
              color: RestaurantColors.onPrimary.color,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          color: RestaurantColors.onPrimary.color,
          iconSize: RestaurantTextStyles.headlineLarge.fontSize,
          onPressed: () {
            Navigator.pushNamed(context, NavigationRoute.searchRoute.name);
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Discover Your Next Favorite Spot!",
            style: RestaurantTextStyles.titleMedium.copyWith(
              color: RestaurantColors.secondary.color,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
