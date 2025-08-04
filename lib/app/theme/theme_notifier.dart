import 'package:flutter/material.dart';
import 'theme.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData;
  bool _isDark;
  Color _seedColor;

  ThemeNotifier(this._seedColor, {bool isDark = false})
      : _isDark = isDark,
        _themeData = isDark
            ? AppThemes.darkTheme(_seedColor)
            : AppThemes.lightTheme(_seedColor);

  ThemeData get themeData => _themeData;
  bool get isDark => _isDark;
  Color get seedColor => _seedColor;

  void updateSeedColor(Color color) {
    _seedColor = color;
    _themeData = _isDark
        ? AppThemes.darkTheme(_seedColor)
        : AppThemes.lightTheme(_seedColor);
    notifyListeners();
  }

  void switchTheme() {
    _isDark = !_isDark;
    _themeData = _isDark
        ? AppThemes.darkTheme(_seedColor)
        : AppThemes.lightTheme(_seedColor);
    notifyListeners();
  }
}