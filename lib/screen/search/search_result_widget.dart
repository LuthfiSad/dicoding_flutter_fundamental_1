import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_flutter_dicoding/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_flutter_dicoding/screen/loading_state_widget.dart';
import 'package:restaurant_flutter_dicoding/screen/search/search_error_state_widget.dart';
import 'package:restaurant_flutter_dicoding/static/restaurant_search_result_state.dart';
import 'package:restaurant_flutter_dicoding/screen/home/restaurant_card_widget.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (_, provider, __) {
        final state = provider.resultState;

        if (state is RestaurantSearchNoneState) {
          return const Center(
            child: Text('Enter keywords to search for restaurants.'),
          );
        } else if (state is RestaurantSearchLoadingState) {
          return const Center(child: LoadingStateWidget());
        } else if (state is RestaurantSearchErrorState) {
          return Center(
            child: SearchErrorStateWidget(
              errorMessage: state.error,
            ),
          );
        } else if (state is RestaurantSearchLoadedState) {
          final restaurants = state.data;

          if (restaurants.isEmpty) {
            return const Center(child: Text('No restaurants found.'));
          }

          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return RestaurantCardWidget(
                restaurant: restaurant,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: restaurant.id,
                  );
                },
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
