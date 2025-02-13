import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_dicoding/screen/home/home_appbar_widget.dart';
import 'package:restaurant_flutter_dicoding/static/navigation_route.dart';

void main() {
  testWidgets('HomeAppbarWidget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          NavigationRoute.searchRoute.name: (_) => Container(),
        },
        home: const Scaffold(
          appBar: HomeAppbarWidget(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.restaurant_rounded), findsOneWidget);

    expect(find.text('Restaurant'), findsOneWidget);

    expect(find.byIcon(Icons.search), findsOneWidget);

    expect(find.text('Discover Your Next Favorite Spot!'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.byType(Container), findsOneWidget);
  });
}
