import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/utils/ui.dart';
import 'package:myarchapp/features/settings/providers/language_provider.dart';
import 'package:myarchapp/generated/l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.settings),
      ),
      body: const _LanguageSettings(),
    );
  }
}

class _LanguageSettings extends ConsumerWidget {
  const _LanguageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageState = ref.watch(languageProvider);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          primary: Colors.grey[400],
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.language),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Language'),
                Text(languageState),
              ],
            )
          ],
        ),
        onPressed: () {
          showModalBottomSheet(
            shape: AppShapes.bottomSheetShape,
            context: context,
            builder: (context) => const _LanguageBottomSheet(),
          );
        },
      ),
    );
  }
}

class _LanguageBottomSheet extends ConsumerWidget {
  const _LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localesNumber = S.delegate.supportedLocales.length;
    final languageState = ref.watch(languageProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Choose a language:',
              style: TextStyle(
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
                      S.delegate.supportedLocales[index].languageCode;

                  return ListTile(
                    shape: AppShapes.listTileShape,
                    dense: true,
                    tileColor: localeName == languageState
                        ? Colors.grey[300]
                        : Colors.transparent,
                    onTap: () {
                      ref.read(languageProvider.notifier).state = localeName;
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
