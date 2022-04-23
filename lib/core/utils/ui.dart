import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  static const accent = Colors.blueGrey;
}

class AppAssets {
  static const clouds = 'assets/clouds.svg';
  static const rain = 'assets/rain.svg';
  static const sun = 'assets/sun.svg';
}

class AppTheme {
  static final theme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.accent,
    ),
  );
}
