import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider = StateProvider.autoDispose<String>(
  (ref) => 'ru',
);
