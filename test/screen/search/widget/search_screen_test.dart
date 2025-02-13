import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_flutter_dicoding/data/api/api_services.dart';
import 'package:restaurant_flutter_dicoding/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_flutter_dicoding/screen/search/search_screen.dart';
import 'package:restaurant_flutter_dicoding/screen/search/search_appbar_widget.dart';
import 'package:restaurant_flutter_dicoding/screen/search/search_bar_widget.dart';

void main() {
  testWidgets('SearchScreen has app bar, search bar',
      (WidgetTester tester) async {
    // Menyediakan provider RestaurantSearchProvider
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider(
            create: (context) => ApiServices(),
          ),
          ChangeNotifierProvider(
            create: (context) => RestaurantSearchProvider(
              context.read<ApiServices>(),
            ),
          ),
        ],
        child: MaterialApp(home: SearchScreen()),
      ),
    );

    expect(find.byType(SearchAppbarWidget), findsOneWidget);
    expect(find.byType(SearchBarWidget), findsOneWidget);
    final textField = find.byType(TextField);
    await tester.enterText(textField, 'restaurant');
    await tester.pump(); 

    expect(find.text('restaurant'), findsOneWidget);

    final searchController = tester.widget<TextField>(textField);
    expect(searchController.controller?.text, 'restaurant');
  });
}
