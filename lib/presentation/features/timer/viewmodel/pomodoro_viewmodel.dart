import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/data/services/audio_service.dart';
import 'package:pomodoro_app/data/services/notification_service.dart';
import 'package:pomodoro_app/domain/pomodoro_rules.dart';

// enum para os states do pomodoro
enum PomodoroState { focus, shortBreak, longBreak, idle }

class PomodoroViewModel extends ChangeNotifier {
  // var para o audio service
  final AudioService audioService = AudioService();
  // ao abrir o app, estado do pomo sera idle
  PomodoroState _currentState = PomodoroState.idle;
  Duration _timeRemaining = PomodoroRules.focusDuration;
  bool _timeIsRunning = false;
  int _currentCycle = 0;
  int get currentCycle => _currentCycle;

  // Getters publicos - para a pomodoro_view.dart ler as variaveis privadas
  PomodoroState get currentState => _currentState;
  Duration get timeRemaining => _timeRemaining;
  bool get timeIsRunning => _timeIsRunning;

  Timer? _timer;

  void timerTick(Timer timer) {
    if (_timeRemaining.inSeconds > 0) {
      _timeRemaining -= const Duration(seconds: 1);

      // Atualiza noti com tempo restante
      NotificationService().showNotification(
        id: 0,
        title: "Pomodoro Timer",
        body: "${_currentStateFormatted()}: ${_formatDuration(_timeRemaining)}",
        color: _currentStateFormatted() == "Focus"
            ? Color.fromARGB(255, 133, 55, 55) // focus background color
            : _currentStateFormatted() == "Short"
            ? Color.fromARGB(255, 78, 134, 114) // short break background color
            : Color.fromARGB(255, 60, 99, 128), // long break background color
      );
    } else {
      // if time ended, switch pomodoro state
      _switchState();
    }
    notifyListeners(); // Notifica a UI a cada segundo
  }

  // Helper para formatar o tempo
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  String _currentStateFormatted() {
    switch (_currentState) {
      case PomodoroState.focus:
        return "Focus";
      case PomodoroState.shortBreak:
        return "Short";
      case PomodoroState.longBreak:
        return "Long";
      case PomodoroState.idle:
        return "Idle";
    }
  }

  void startOrPause() {
    if (_timeIsRunning) {
      _timer?.cancel();
    } else {
      if (_currentState == PomodoroState.idle) {
        _currentState = PomodoroState.focus;
      }
      _timer = Timer.periodic(const Duration(seconds: 1), timerTick);
    }
    _timeIsRunning = !_timeIsRunning;
    notifyListeners();
  }

  void resetTimer() {
    _timer?.cancel();
    _timeIsRunning = false;
    //_currentState = PomodoroState.idle;
    if (_currentState == PomodoroState.focus) {
      _timeRemaining = PomodoroRules.focusDuration;
    } else if (_currentState == PomodoroState.shortBreak) {
      _timeRemaining = PomodoroRules.shortBreakDuration;
    } else if (_currentState == PomodoroState.longBreak) {
      _timeRemaining = PomodoroRules.longBreakDuration;
    } else {
      _timeRemaining = PomodoroRules.focusDuration;
    }

    _currentCycle = 0;
    notifyListeners();
  }

  void skipToNext() {
    _timer?.cancel(); // stops timer
    _timeIsRunning = false;
    _switchState();
    notifyListeners(); // atualizar UI
  }

  void _switchState() {
    PomodoroState previousState = _currentState;
    switch (_currentState) {
      case PomodoroState.focus:
        _currentCycle++; // Incrementa o ciclo de foco concluído
        if (_currentCycle == PomodoroRules.cyclesBeforeLongBreak) {
          // Inicia uma pausa longa após N ciclos
          _timer?.cancel();
          _currentState = PomodoroState.longBreak;
          _timeRemaining = PomodoroRules.longBreakDuration;

          // play(long break alarm)
          audioService.playLongAlarm();

          onStateChanged?.call(_currentState);
        } else {
          // Inicia uma pausa curta
          _timer?.cancel();
          _currentState = PomodoroState.shortBreak;
          _timeRemaining = PomodoroRules.shortBreakDuration;

          // play(short break alarm)
          audioService.playShortAlarm();
          onStateChanged?.call(_currentState);
        }
        break;
      case PomodoroState.shortBreak:
      case PomodoroState.longBreak:
        // Depois de qualquer pausa, volta para o foco
        _timer?.cancel();
        _currentState = PomodoroState.focus;
        _timeRemaining = PomodoroRules.focusDuration;
        // play(focus alarm)
        audioService.playFocusAlarm();
        onStateChanged?.call(_currentState);

        // reset cycles only after longBreak finished
        if (previousState == PomodoroState.longBreak) {
          _currentCycle = 0;
        }
        break;

      case PomodoroState.idle:
        // não é pra acontecer, mas por segurança, reseta
        resetTimer();
        break;
    }
  }

  void Function(PomodoroState)? onStateChanged;

  //Metodos para os text buttons de cima
  void setFocus() {
    _currentState = PomodoroState.focus;
    _timeRemaining = PomodoroRules.focusDuration;
    _timer?.cancel();
    _timeIsRunning = false;
    notifyListeners();
    onStateChanged?.call(_currentState);
  }

  void setShortBreak() {
    _currentState = PomodoroState.shortBreak;
    _timeRemaining = PomodoroRules.shortBreakDuration;
    _timer?.cancel();
    _timeIsRunning = false;
    notifyListeners();
    onStateChanged?.call(_currentState);
  }

  void setLongBreak() {
    _currentState = PomodoroState.longBreak;
    _timeRemaining = PomodoroRules.longBreakDuration;
    _timer?.cancel();
    _timeIsRunning = false;
    notifyListeners();
    onStateChanged?.call(_currentState);
  }
}
