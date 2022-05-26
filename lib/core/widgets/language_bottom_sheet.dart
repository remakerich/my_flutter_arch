import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/utils/ui.dart';
import 'package:myarchapp/core/l10n/localization.dart';
import 'package:myarchapp/modules/settings/controllers/language_provider.dart';

class LanguageBottomSheet extends ConsumerWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localesNumber = AppLocalizations.supportedLocales.length;
    final languageState = ref.watch(languageProvider);
    final locale = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              locale.chooseLanguage,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                localesNumber,
                (index) {
                  final localeName =
                      AppLocalizations.supportedLocales[index].languageCode;

                  return ListTile(
                    shape: AppShapes.listTileShape,
                    dense: true,
                    tileColor: localeName == languageState
                        ? Theme.of(context).cardColor
                        : Colors.transparent,
                    onTap: () {
                      ref
                          .read(languageProvider.notifier)
                          .setLanguage(localeName);
                      Navigator.of(context).pop();
                    },
                    title: Text(
                      localeName,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
