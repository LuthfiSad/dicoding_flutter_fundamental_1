import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_flutter_dicoding/data/local/local_notification_service.dart';
import 'package:restaurant_flutter_dicoding/data/workmanager/workmanager_services.dart';
import 'package:restaurant_flutter_dicoding/provider/setting/local_notification_provider.dart';
import 'package:restaurant_flutter_dicoding/provider/setting/theme_provider.dart';
import 'package:restaurant_flutter_dicoding/screen/setting/setting_screen.dart';

Widget createSettingScreen() => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        Provider(create: (context) => LocalNotificationService()),
        Provider(create: (context) => WorkmanagerService()),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
            context.read<WorkmanagerService>(),
          ),
        ),
      ],
      child: const MaterialApp(
        home: SettingScreen(),
      ),
    );

void main() {
  testWidgets('renders setting screen with all basic elements',
      (WidgetTester tester) async {
    await tester.pumpWidget(createSettingScreen());

    expect(find.text('Setting'), findsOneWidget);

    expect(find.text('Theme'), findsOneWidget);

    expect(find.text('Dark Theme'), findsOneWidget);

    expect(find.text('Notifications'), findsOneWidget);

    expect(find.byType(Switch), findsNWidgets(2));
  });
}
