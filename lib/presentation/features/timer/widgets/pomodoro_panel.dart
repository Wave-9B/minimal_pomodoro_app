import 'package:flutter/material.dart';
//import 'package:pomodoro_app/app/theme/theme_notifier.dart';
import 'package:pomodoro_app/presentation/features/timer/viewmodel/pomodoro_viewmodel.dart';
import 'package:pomodoro_app/presentation/features/timer/widgets/action_buttons.dart';
import 'package:pomodoro_app/presentation/features/timer/widgets/pomodoro_timer.dart';
import 'package:pomodoro_app/presentation/widgets/neumorph_button.dart';
//import 'package:pomodoro_app/presentation/widgets/neumorph_button.dart';
import 'package:provider/provider.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final pomoViewModel = Provider.of<PomodoroViewModel>(context);
    //  bool isDark = Provider.of<ThemeNotifier>(context).isDark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NeumorphicButton(
              isButtonActive: pomoViewModel.currentState == PomodoroState.focus,
              height: 40,
              width: 80,
              isCircle: false,
              paddingSize: EdgeInsets.all(0),
              onPressed: () => pomoViewModel.setFocus(),
              child: Text("Focus", textAlign: TextAlign.center),
            ),
            SizedBox(width: 12),
            NeumorphicButton(
              isButtonActive:
                  pomoViewModel.currentState == PomodoroState.shortBreak,
              height: 40,
              width: 80,
              isCircle: false,
              paddingSize: EdgeInsets.all(0),
              onPressed: () => pomoViewModel.setShortBreak(),
              child: Text("Short", textAlign: TextAlign.center),
            ),
            SizedBox(width: 12),
            NeumorphicButton(
              isButtonActive:
                  pomoViewModel.currentState == PomodoroState.longBreak,
              height: 40,
              width: 80,
              isCircle: false,
              paddingSize: EdgeInsets.all(0),
              onPressed: () => pomoViewModel.setLongBreak(),
              child: Text("Long", textAlign: TextAlign.center),
            ),
          ],
        ),
        SizedBox(height: 16),
        // timer UI
        PomodoroTimer(),
        SizedBox(height: 20),
        ActionButtons(),
      ],
    );
  }
}
