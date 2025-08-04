import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioService extends ChangeNotifier {
  final player = AudioPlayer();
  String focusAlarmPath = "sounds/focus_alarm.mp3";
  String shortAlarmPath = "sounds/short_alarm.mp3";
  String longAlarmPath = "sounds/long_alarm.mp3";

  double audioVol = 0.3;

  //methods below will play the alarms sound for each pomodoro state

  void playFocusAlarm() async {
    await player.setVolume(audioVol);
    await player.play(AssetSource(focusAlarmPath));
  }

  void playShortAlarm() async {
    await player.setVolume(audioVol);
    await player.play(AssetSource(shortAlarmPath));
  }

  void playLongAlarm() async {
    await player.setVolume(audioVol);
    await player.play(AssetSource(longAlarmPath));
  }
}
