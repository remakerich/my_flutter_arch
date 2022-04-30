import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider =
    StateNotifierProvider.autoDispose<LanguageNotifier, String>(
  (ref) {
    return LanguageNotifier();
  },
);

class LanguageNotifier extends StateNotifier<String> {
  LanguageNotifier() : super('ru') {
    started();
  }

  void started() {}

  void setLanguage(String language) {
    state = language;
  }
}
