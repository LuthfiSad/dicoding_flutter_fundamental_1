import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_dicoding/screen/detail/detail_appbar_widget.dart';
import 'package:restaurant_flutter_dicoding/style/colors/restaurant_colors.dart';
import 'package:restaurant_flutter_dicoding/style/typography/restaurant_text_styles.dart';

void main() {
  testWidgets('DetailAppbarWidget has the correct title and style',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: DetailAppbarWidget(),
        ),
      ),
    );

    expect(find.text('Restaurant Detail'), findsOneWidget);

    final textWidget =
        tester.firstWidget(find.text('Restaurant Detail')) as Text;
    expect(textWidget.style?.color, RestaurantColors.onPrimary.color);
    expect(textWidget.style?.fontSize,
        RestaurantTextStyles.headlineSmall.fontSize);
  });
}
