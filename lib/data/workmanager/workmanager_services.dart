import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:restaurant_flutter_dicoding/data/api/api_services.dart';
import 'package:restaurant_flutter_dicoding/data/local/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'daily_notification_task') {
      try {
        final apiServices = ApiServices();
        final restaurantResponse = await apiServices.getRestaurantList();

        if (!restaurantResponse.error &&
            restaurantResponse.restaurants.isNotEmpty) {
          final random = Random();
          final randomIndex =
              random.nextInt(restaurantResponse.restaurants.length);
          final randomRestaurant = restaurantResponse.restaurants[randomIndex];

          final notificationService = LocalNotificationService();
          await notificationService.initialize();
          await notificationService.showNotification(
            id: 1,
            title: 'Restaurant Recommendation: ${randomRestaurant.name}',
            body:
                'Rating: ${randomRestaurant.rating}. Come and enjoy delicious food at ${randomRestaurant.name}!',
          );
        }
      } on SocketException {
        debugPrint('Background task failed: No internet connection');
      } on HttpException {
        debugPrint('Background task failed: Failed to reach server');
      } on FormatException {
        debugPrint('Background task failed: Invalid response format');
      } catch (e) {
        debugPrint('Background task failed: ${e.toString()}');
      }
    }
    return Future.value(true);
  });
}

class WorkmanagerService {
  static final _instance = WorkmanagerService._internal();
  factory WorkmanagerService() => _instance;
  WorkmanagerService._internal();

  Future initializeService() async {
    try {
      await Workmanager().initialize(callbackDispatcher);
    } catch (e) {
      debugPrint('Failed to initialize workmanager service: ${e.toString()}');
    }
  }

  Future scheduleDailyNotification() async {
    try {
      final initialDelay = _calculateInitialDelay();

      await Workmanager().registerPeriodicTask(
        'daily_task',
        'daily_notification_task',
        frequency: const Duration(days: 1),
        initialDelay: initialDelay,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
        existingWorkPolicy: ExistingWorkPolicy.replace,
      );
      return true;
    } catch (e) {
      debugPrint('Failed to schedule notification: ${e.toString()}');
      return false;
    }
  }

  Duration _calculateInitialDelay() {
    final now = DateTime.now();
    final targetTime = DateTime(now.year, now.month, now.day, 11, 0);

    if (now.isAfter(targetTime)) {
      return targetTime.add(const Duration(days: 1)).difference(now);
    } else {
      return targetTime.difference(now);
    }
  }

  Future cancelAllTasks() async {
    try {
      await Workmanager().cancelAll();
      return true;
    } catch (e) {
      debugPrint('Failed to cancel tasks: ${e.toString()}');
      return false;
    }
  }
}
