import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/utils/ui.dart';
import 'package:myarchapp/core/l10n/localization.dart';
import 'package:myarchapp/features/settings/providers/theme_provider.dart';

class ThemeBottomSheet extends ConsumerWidget {
  const ThemeBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    final themeState = ref.watch(themeProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              locale.chooseTheme,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                AppTheme.allThemes.length,
                (index) {
                  return ListTile(
                    shape: AppShapes.listTileShape,
                    dense: true,
                    tileColor: AppTheme.allThemes[index] == themeState
                        ? Theme.of(context).cardColor
                        : Colors.transparent,
                    title: Text(
                      AppTheme.allThemes[index].name,
                    ),
                    onTap: () {
                      ref.read(themeProvider.notifier).state =
                          AppTheme.allThemes[index];
                      Navigator.of(context).pop();
                    },
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
