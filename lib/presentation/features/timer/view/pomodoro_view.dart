import 'package:flutter/material.dart';
import 'package:pomodoro_app/app/theme/theme.dart';
import 'package:pomodoro_app/app/theme/theme_notifier.dart';
import 'package:pomodoro_app/data/services/audio_service.dart';
import 'package:pomodoro_app/presentation/features/timer/viewmodel/pomodoro_viewmodel.dart';
import 'package:pomodoro_app/presentation/features/timer/widgets/pomodoro_panel.dart';
import 'package:pomodoro_app/presentation/widgets/neumorph_button.dart';
import 'package:provider/provider.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  double _devTextOpacity = 1.0; // dev text opacity value
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _devTextOpacity = 0.0;
        });
      }
    });

    final pomoViewModel = Provider.of<PomodoroViewModel>(
      context,
      listen: false,
    );
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);

    pomoViewModel.onStateChanged = (state) {
      switch (state) {
        case PomodoroState.focus:
          themeNotifier.updateSeedColor(AppThemes.focusBackgroundColor);
          break;
        case PomodoroState.shortBreak:
          themeNotifier.updateSeedColor(AppThemes.breakBackgroundColor);
          break;
        case PomodoroState.longBreak:
          themeNotifier.updateSeedColor(AppThemes.longBreakBackgroundColor);
          break;
        case PomodoroState.idle:
          themeNotifier.updateSeedColor(
            AppThemes.focusBackgroundColor,
          ); // ou outra cor padrão
          break;
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(
      context,
    ); // accessing the themeProvider
    int currentCycle = Provider.of<PomodoroViewModel>(context).currentCycle;
    return Scaffold(
      appBar: AppBar(title: Text('Pomodoro Timer')),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              // padding for timer display
              padding: const EdgeInsets.all(16.0),
              child: TimerDisplay(),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NeumorphicButton(
                  onPressed: () {},
                  isClickable: false,
                  paddingSize: EdgeInsets.all(6),
                  child: Icon(
                    size: 20,
                    color: themeNotifier.isDark
                        ? themeNotifier.seedColor
                        : themeNotifier.themeData.primaryColor,
                    currentCycle >= 1 ? Icons.circle : Icons.circle_outlined,
                  ),
                ),
                SizedBox(width: 9),
                NeumorphicButton(
                  onPressed: () {},
                  paddingSize: EdgeInsets.all(6),
                  isClickable: false,
                  child: Icon(
                    size: 20,
                    color: themeNotifier.isDark
                        ? themeNotifier.seedColor
                        : themeNotifier.themeData.primaryColor,
                    currentCycle >= 2 ? Icons.circle : Icons.circle_outlined,
                  ),
                ),
                SizedBox(width: 9),
                NeumorphicButton(
                  onPressed: () {},
                  paddingSize: EdgeInsets.all(6),
                  isClickable: false,
                  child: Icon(
                    size: 20,
                    color: themeNotifier.isDark
                        ? themeNotifier.seedColor
                        : themeNotifier.themeData.primaryColor,
                    currentCycle >= 3 ? Icons.circle : Icons.circle_outlined,
                  ),
                ),
                SizedBox(width: 9),
                NeumorphicButton(
                  onPressed: () {},
                  paddingSize: EdgeInsets.all(6),
                  isClickable: false,
                  child: Icon(
                    size: 20,
                    color: themeNotifier.isDark
                        ? themeNotifier.seedColor
                        : themeNotifier.themeData.primaryColor,
                    currentCycle >= 4 ? Icons.circle : Icons.circle_outlined,
                  ),
                ),
                SizedBox(width: 9),
              ],
            ),
            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeumorphicButton(
                  //isButtonActive: themeNotifier.isDark,
                  paddingSize: EdgeInsets.all(10),

                  onPressed: () => themeNotifier.switchTheme(),

                  child: themeNotifier.isDark
                      ? Icon(
                          Icons.dark_mode_outlined,
                          color: themeNotifier.themeData.colorScheme.primary,
                        )
                      : Icon(
                          Icons.light_mode_outlined,
                          color: themeNotifier.themeData.colorScheme.primary,
                        ),
                ),

                Consumer<AudioService>(
                  builder: (context, audioService, child) => NeumorphicButton(
                    paddingSize: EdgeInsets.all(10),
                    onPressed: () => audioService.changeVolume(),
                    child: Icon(
                      audioService.isMuted ? Icons.volume_off : Icons.volume_up,
                      color: themeNotifier.themeData.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 60),

            AnimatedOpacity(
              opacity: _devTextOpacity,
              duration: const Duration(seconds: 5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "dev by: @wave9b",
                  style: TextStyle(
                    color: themeNotifier.themeData.colorScheme.primary
                        .withAlpha(100),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
