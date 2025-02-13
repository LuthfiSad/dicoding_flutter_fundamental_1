import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_flutter_dicoding/provider/favorite/local_database_provider.dart';
import 'package:restaurant_flutter_dicoding/screen/favorite/favorite_card_widget.dart';
import 'package:restaurant_flutter_dicoding/style/colors/restaurant_colors.dart';
import 'package:restaurant_flutter_dicoding/style/typography/restaurant_text_styles.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllRestaurant();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.favorite,
              color: RestaurantColors.onPrimary.color,
            ),
            const SizedBox(width: 8),
            Text(
              "Favorite",
              style: RestaurantTextStyles.headlineSmall.copyWith(
                color: RestaurantColors.onPrimary.color,
              ),
            ),
          ],
        ),
      ),
      body: Consumer<LocalDatabaseProvider>(builder: (context, value, child) {
        final favoriteList = value.restaurantList;
        return switch (favoriteList.isNotEmpty) {
          true => ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final restaurant = favoriteList[index];
                return FavoriteCardWidget(
                  restaurant: restaurant,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: restaurant.id,
                    );
                  },
                );
              }),
          _ => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("No Favorited")],
              ),
            )
        };
      }),
    );
  }
}
