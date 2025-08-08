import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final notificationPlugin = FlutterLocalNotificationsPlugin();

  final bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // here the noti is initialized
  Future<void> initNotification() async {
    if (_isInitialized) return; // prevent to initialzie again

    // android init settings
    const initSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // iOS init settings
    const initSettingsiOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // windows init settings
    // const initSettingsWin = WindowsInitializationSettings(
    //   appName: "Pomodoro Timer",
    //   appUserModelId: "pomodoro_app",
    //   guid: "guid",
    // );

    // init settings (both platforms)
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsiOS,
      //windows: initSettingsWin,
    );

    // init the notification plugin (After the each platform setup)
    await notificationPlugin.initialize(initSettings);
  }

  // here is the notifications details
  NotificationDetails notificationDetails({Color? color}) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "channelId",
        "channelName",
        channelDescription: "pomodoro timer",
        importance: Importance.max,
        priority: Priority.high,
        playSound: false,
        onlyAlertOnce: true,
        ongoing: true, // deixa notificação fixada enquanto timer esta rodando
        showWhen: false,
        color: color,
      ),
      iOS: DarwinNotificationDetails(presentSound: false),
      //windows: WindowsNotificationDetails(),
    );
  }

  // here shows the notifications
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    required Color color,
  }) async {
    return notificationPlugin.show(
      id,
      title,
      body,
      notificationDetails(color: color),
    );
  }

  Future<void> requestNotificationPermission() async {
    final androidImplementation = notificationPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidImplementation?.requestNotificationsPermission();
  }
}
