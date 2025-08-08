import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:pomodoro_app/app/theme/theme.dart';
import 'package:pomodoro_app/app/theme/theme_notifier.dart';
import 'package:pomodoro_app/data/services/audio_service.dart';
import 'package:pomodoro_app/data/services/notification_service.dart';
import 'package:pomodoro_app/presentation/features/timer/view/pomodoro_view.dart';
import 'package:pomodoro_app/presentation/features/timer/viewmodel/pomodoro_viewmodel.dart';
import 'package:provider/provider.dart';

late Box myBox;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init hive
  await Hive.initFlutter();

  // open the box
  myBox = await Hive.openBox("MY_BOX");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(AppThemes.focusBackgroundColor, myBox),
        ),
        ChangeNotifierProvider(create: (_) => PomodoroViewModel()),
        ChangeNotifierProvider(create: (_) => AudioService()),
      ],

      child: const MyApp(),
    ),
  );
  // init notification
  NotificationService().initNotification();
  NotificationService().requestNotificationPermission();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Pomodoro Timer',
      navigatorKey: navigatorKey,
      theme: themeNotifier.themeData,
      home: const PomodoroScreen(),
    );
  }
}
