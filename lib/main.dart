import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_flutter_dicoding/data/api/api_services.dart';
import 'package:restaurant_flutter_dicoding/data/local/local_database_service.dart';
import 'package:restaurant_flutter_dicoding/data/local/local_notification_service.dart';
import 'package:restaurant_flutter_dicoding/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_flutter_dicoding/provider/favorite/local_database_provider.dart';
import 'package:restaurant_flutter_dicoding/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_flutter_dicoding/provider/main/index_nav_provider.dart';
import 'package:restaurant_flutter_dicoding/provider/review/restaurant_add_review_provider.dart';
import 'package:restaurant_flutter_dicoding/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_flutter_dicoding/provider/setting/local_notification_provider.dart';
import 'package:restaurant_flutter_dicoding/provider/setting/theme_provider.dart';
import 'package:restaurant_flutter_dicoding/screen/detail/detail_screen.dart';
import 'package:restaurant_flutter_dicoding/screen/main/main_screen.dart';
import 'package:restaurant_flutter_dicoding/screen/search/search_screen.dart';
import 'package:restaurant_flutter_dicoding/static/navigation_route.dart';
import 'package:restaurant_flutter_dicoding/style/theme/restaurant_theme.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  final localNotificationService = LocalNotificationService();
  final notificationProvider =
      LocalNotificationProvider(localNotificationService);
  await notificationProvider.initialize();
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantSearchProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantAddReviewProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        Provider(
          create: (context) => LocalDatabaseService(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider(
            context.read<LocalDatabaseService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        Provider(create: (context) => LocalNotificationService()),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => notificationProvider,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: "Restaurant App",
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: themeProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
        NavigationRoute.searchRoute.name: (context) => SearchScreen(),
      },
    );
  }
}
