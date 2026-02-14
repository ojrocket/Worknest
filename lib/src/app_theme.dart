import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF075E54); // WhatsApp Dark Teal
  static const secondary = Color(0xFF128C7E); // WhatsApp Teal
  static const lightGreen = Color(0xFF25D366); // WhatsApp Green
  static const chatBackground = Color(0xFFECE5DD);
  static const bubbleSelf = Color(0xFFDCF8C6);
  static const bubbleOther = Color(0xFFFFFFFF);
  
  static const ink = Color(0xFF000000);
  static const night = Color(0xFF121B22); // Dark mode bg
  static const surfaceDark = Color(0xFF1F2C34);
  static const mist = Color(0xFFE9EDEF);
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
      backgroundColor: AppColors.lightGreen,
      foregroundColor: Colors.white,
      shape: CircleBorder(),
    ),
  );
}

