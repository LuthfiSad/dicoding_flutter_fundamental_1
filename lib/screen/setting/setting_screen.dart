import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_flutter_dicoding/provider/setting/local_notification_provider.dart';
import 'package:restaurant_flutter_dicoding/provider/setting/theme_provider.dart';
import 'package:restaurant_flutter_dicoding/style/colors/restaurant_colors.dart';
import 'package:restaurant_flutter_dicoding/style/typography/restaurant_text_styles.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final notificationProvider =
        Provider.of<LocalNotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.settings,
              color: RestaurantColors.onPrimary.color,
            ),
            const SizedBox(width: 8),
            Text(
              "Setting",
              style: RestaurantTextStyles.headlineSmall.copyWith(
                color: RestaurantColors.onPrimary.color,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Theme",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text("Dark Theme"),
              value: themeProvider.isDarkTheme,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Notifications",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text("Enable Notifications"),
              value: notificationProvider.isNotificationEnabled,
              onChanged: (value) {
                notificationProvider.toggleNotification(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
