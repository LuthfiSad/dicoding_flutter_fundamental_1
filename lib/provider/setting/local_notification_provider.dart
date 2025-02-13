import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_flutter_dicoding/data/local/local_notification_service.dart';
import 'package:restaurant_flutter_dicoding/data/workmanager/workmanager_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService notificationService;
  final WorkmanagerService workmanagerService;

  LocalNotificationProvider(this.notificationService, this.workmanagerService);

  bool _isNotificationEnabled = false;
  bool? _permission;
  String? _error;

  bool get isNotificationEnabled => _isNotificationEnabled;
  bool? get permission => _permission;
  String? get error => _error;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isNotificationEnabled = prefs.getBool('isNotificationEnabled') ?? false;

      await notificationService.initialize();
      await workmanagerService.initializeService();

      _permission = await notificationService.requestPermissions();
      if (_permission == true) {
        await notificationService.configureLocalTimeZone();

        if (_isNotificationEnabled) {
          await _enableNotifications();
        } else {
          await _disableNotifications();
        }
      }

      await checkPendingNotificationRequests();
      _error = null;
    } catch (e) {
      _error = 'Failed to initialize notifications: ${e.toString()}';
      debugPrint(_error);
    } finally {
      notifyListeners();
    }
  }

  Future<void> _enableNotifications() async {
    try {
      final scheduled = await workmanagerService.scheduleDailyNotification();
      if (!scheduled) {
        _error = 'Failed to schedule background notifications';
      }
    } catch (e) {
      _error = 'Failed to enable notifications: ${e.toString()}';
      debugPrint(_error);
    }
  }

  Future<void> _disableNotifications() async {
    try {
      final cancelled = await workmanagerService.cancelAllTasks();
      if (!cancelled) {
        _error = 'Failed to cancel background notifications';
      }
    } catch (e) {
      _error = 'Failed to disable notifications: ${e.toString()}';
      debugPrint(_error);
    }
  }

  Future<void> toggleNotification(bool value) async {
    _isNotificationEnabled = value;
    notifyListeners();

    if (_isNotificationEnabled) {
      _permission = await notificationService.requestPermissions();
      if (_permission == true) {
        await _enableNotifications();
      } else {
        _isNotificationEnabled = false;
        notifyListeners();
        await _disableNotifications();
      }
    } else {
      await _disableNotifications();
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isNotificationEnabled', _isNotificationEnabled);
    await checkPendingNotificationRequests();
  }

  Future<void> checkPendingNotificationRequests() async {
    pendingNotificationRequests =
        await notificationService.pendingNotificationRequests();
    debugPrint(
        "Pending notifications: ${pendingNotificationRequests.map((e) => e.id).toList()}");
    notifyListeners();
  }
}
