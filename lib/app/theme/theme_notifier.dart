import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'theme.dart';

class ThemeNotifier extends ChangeNotifier {
  final Box _box; // var para salvar o theme
  ThemeData _themeData;
  bool _isDark;
  Color _seedColor;

  ThemeNotifier(this._seedColor, this._box, {bool isDark = false})
    : _isDark = _box.get("isDark", defaultValue: isDark), // : -> prepare the initial value
      _themeData = _box.get("isDark", defaultValue: isDark)
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

    _box.put("isDark", _isDark);
    notifyListeners();
  }
}
