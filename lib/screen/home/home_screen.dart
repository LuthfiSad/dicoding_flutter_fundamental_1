import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_flutter_dicoding/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_flutter_dicoding/screen/home/home_error_state_widget.dart';
import 'package:restaurant_flutter_dicoding/screen/home/home_appbar_widget.dart';
import 'package:restaurant_flutter_dicoding/screen/home/restaurant_list_widget.dart';
import 'package:restaurant_flutter_dicoding/screen/loading_state_widget.dart';
import 'package:restaurant_flutter_dicoding/static/restaurant_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _fetchRestaurantList();
  }

  void _fetchRestaurantList() {
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Consumer<RestaurantListProvider>(
          builder: (_, provider, __) {
            switch (provider.resultState) {
              case RestaurantListLoadingState():
                return const LoadingStateWidget();
              case RestaurantListLoadedState(data: var restaurantList):
                return RestaurantListWidget(
                  restaurants: restaurantList,
                  onRetry: _fetchRestaurantList,
                );
              case RestaurantListErrorState(error: var message):
                return HomeErrorStateWidget(
                  errorMessage: message,
                  onRetry: _fetchRestaurantList,
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
