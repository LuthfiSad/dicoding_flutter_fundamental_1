import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> initialize() async {
    const InitializationSettings initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<bool> requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iOSImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      return await iOSImplementation?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final requestNotificationsPermission =
          await androidImplementation?.requestNotificationsPermission();

      final permissionStatus = await Permission.notification.request();

      final notificationEnabled = await _isAndroidPermissionGranted();

      return (requestNotificationsPermission ?? false) &&
          permissionStatus.isGranted &&
          notificationEnabled;
    }
    return false;
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        '99',
        'Restaurant App',
        channelDescription: 'Lunch Schedule Notification',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }

  Future<List<PendingNotificationRequest>> pendingNotificationRequests() async {
    return await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<bool> _isAndroidPermissionGranted() async {
    final androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    return await androidImplementation?.areNotificationsEnabled() ?? false;
  }
}
