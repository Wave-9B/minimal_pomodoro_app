import 'package:flutter/material.dart';

class AppThemes {
  static const focusBackgroundColor = Color.fromARGB(255, 133, 55, 55);
  static const breakBackgroundColor = Color.fromARGB(255, 78, 134, 114);
  static const longBreakBackgroundColor = Color.fromARGB(255, 60, 99, 128);
   // bright shadow for light mode
  static Color lightShadowLightMode(Color bgColor) =>
      Color.lerp(bgColor, Colors.white, 1)!;

  // dark shadow for light mode
  static Color darkShadowLightMode(Color bgColor) =>
      Color.lerp(bgColor, Colors.grey.shade400, 1)!;

  // bright shadow for dark mode
  static Color lightShadowDarkMode(Color bgColor) =>
      Color.lerp(bgColor, Colors.white, 0.2)!;

  // dark shadow for dark mode
  static Color darkShadowDarkMode(Color bgColor) =>
      Color.lerp(bgColor, Colors.black, 1)!;

  static ThemeData lightTheme(Color seedColor) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
        
      ),
    );
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: theme.colorScheme.primary, // Text tem a cor principal do tema
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 5,
        ),
      ),
      textTheme: theme.textTheme.apply(bodyColor: theme.colorScheme.primary),
    );
  }

  static ThemeData darkTheme(Color seedColor) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
        surface: seedColor.withAlpha(80),
      ),
    );
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: theme.colorScheme.primary, // Usa cor principal do tema
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 5,
        ),
      ),
      textTheme: theme.textTheme.apply(bodyColor: theme.colorScheme.primary),
    );
  }
}
