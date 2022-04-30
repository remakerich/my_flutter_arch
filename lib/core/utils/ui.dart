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
  );
}

abstract class AppShapes {
  static const bottomSheetShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
    ),
  );

  static final listTileShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  );
}
