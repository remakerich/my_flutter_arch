import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider.autoDispose<ThemeMode>(
  (ref) => ThemeMode.system,
);