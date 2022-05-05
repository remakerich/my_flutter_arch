import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/injection/injection.dart';
import 'package:myarchapp/features/settings/storages/language_storage.dart';

final languageProvider =
    StateNotifierProvider.autoDispose<LanguageNotifier, String>(
  (ref) {
    return LanguageNotifier(
      getIt<LanguageStorage>(),
    );
  },
);

class LanguageNotifier extends StateNotifier<String> {
  LanguageNotifier(
    this._languageStorage,
  ) : super('ru') {
    started();
  }

  final LanguageStorage _languageStorage;

  Future<void> started() async {
    final result = await _languageStorage.getLanguage();

    result.when(
      left: (failure) {},
      right: (language) {
        if (language.isEmpty) {
          state = 'ru';
          return;
        }
        state = language;
      },
    );
  }

  Future<void> setLanguage(String language) async {
    state = language;
    await _languageStorage.setLanguage(language: language);
  }
}
