import 'package:flutter/material.dart';
import 'package:pomodoro_app/app/theme/theme_notifier.dart';
import 'package:pomodoro_app/presentation/features/timer/viewmodel/pomodoro_viewmodel.dart';
import 'package:pomodoro_app/presentation/widgets/neumorph_button.dart';
import 'package:provider/provider.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final pomoViewModel = Provider.of<PomodoroViewModel>(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NeumorphicButton(
          onPressed: () {
            pomoViewModel.resetTimer();
          },

          child: Icon(
            size: 25,
            Icons.refresh,
            color: themeNotifier.themeData.colorScheme.primary,
          ),
        ),
        NeumorphicButton(
          isButtonActive: pomoViewModel.timeIsRunning,
          onPressed: () {
            pomoViewModel.startOrPause();
          },

          child: Icon(
            pomoViewModel.timeIsRunning ? Icons.pause : Icons.play_arrow,
            size: 35,
            color: themeNotifier.themeData.colorScheme.primary,
          ),
        ),
        NeumorphicButton(
          onPressed: () {
            pomoViewModel.skipToNext();
          },
          child: Icon(
            size: 25,
            Icons.skip_next,
            color: themeNotifier.themeData.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
