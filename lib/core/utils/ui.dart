import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AppColors {
  static const accent = Colors.blueGrey;
}

abstract class AppAssets {
  static const clouds = 'assets/clouds.svg';
  static const rain = 'assets/rain.svg';
  static const sun = 'assets/sun.svg';
}

abstract class AppTheme {
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
    cardColor: Colors.grey[300],
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.accent,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
  );

  static const allThemes = [
    ThemeMode.dark,
    ThemeMode.light,
    ThemeMode.system,
  ];
}

abstract class AppShapes {
  static const bottomSheetShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(AppShapes.borderRadius),
      topRight: Radius.circular(AppShapes.borderRadius),
    ),
  );

  static final listTileShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppShapes.borderRadius),
  );

  static const borderRadius = 12.0;

  static const padding = 10.0;
}
