import 'package:flutter/material.dart';
import 'package:pomodoro_app/app/theme/theme.dart';
import 'package:pomodoro_app/app/theme/theme_notifier.dart';
import 'package:pomodoro_app/presentation/features/timer/viewmodel/pomodoro_viewmodel.dart';
import 'package:provider/provider.dart';

class PomodoroTimer extends StatelessWidget {
  const PomodoroTimer({super.key});

  @override
  Widget build(BuildContext context) {
    final pomoViewModel = Provider.of<PomodoroViewModel>(context);
    bool isDark = Provider.of<ThemeNotifier>(context).isDark;
    final bgColor = Theme.of(context).colorScheme.surface;

    final duration = pomoViewModel.timeRemaining;
    final timeText =
        '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.transparent,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? AppThemes.lightShadowDarkMode(bgColor).withAlpha(0)
                : AppThemes.lightShadowLightMode(bgColor),
            offset: const Offset(-4, -4),
            blurRadius: 4,
            spreadRadius: -1,
          ),
          BoxShadow(
            color: isDark
                ? AppThemes.darkShadowDarkMode(bgColor)
                : AppThemes.darkShadowLightMode(bgColor),
            offset: const Offset(4, 4),
            blurRadius: 4,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          timeText,
          style: TextStyle(
            fontSize: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
