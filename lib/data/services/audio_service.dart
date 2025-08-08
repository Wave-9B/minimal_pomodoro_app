import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioService extends ChangeNotifier {
  final player = AudioPlayer();
  String focusAlarmPath = "sounds/focus_alarm.mp3";
  String shortAlarmPath = "sounds/short_alarm.mp3";
  String longAlarmPath = "sounds/long_alarm.mp3";

  double audioVol = 1;

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

  void changeVolume() {
    if (audioVol == 0) {
      audioVol = 1;
    } else {
      audioVol = 0;
    }
    //print ("new volume: $audioVol");
    player.setVolume(audioVol);
    notifyListeners();
  }

  bool get isMuted => audioVol == 0;
}
