import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF3F51B5); // Indigo
  static const secondary = Color(0xFF7986CB); // Lighter Indigo
  static const accent = Color(0xFFFF4081); // Pink Accent
  
  static const chatBackground = Color(0xFFE8EAF6); // Very light indigo
  static const bubbleSelf = Color(0xFF3F51B5); // Primary Indigo for self
  static const bubbleOther = Color(0xFFFFFFFF); // White bubble
  
  static const ink = Color(0xFF263238); // Dark Blue Grey
  static const night = Color(0xFF121212); // Near Black
  static const surfaceDark = Color(0xFF1E1E1E);
  static const mist = Color(0xFFCFD8DC); // Blue Grey Light
  static const paper = Color(0xFFFFFFFF);
}

ThemeData buildTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final bg = isDark ? AppColors.night : AppColors.paper;
  final fg = isDark ? AppColors.mist : AppColors.ink;

  final colorScheme = ColorScheme(
    brightness: brightness,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: isDark ? AppColors.surfaceDark : Colors.white,
    onSurface: fg,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: bg,
    appBarTheme: AppBarTheme(
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.white,
      shape: CircleBorder(),
    ),
  );
}

