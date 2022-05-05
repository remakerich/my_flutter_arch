import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/router/router.dart';
import 'package:myarchapp/core/utils/ui.dart';
import 'package:myarchapp/core/widgets/language_bottom_sheet.dart';
import 'package:myarchapp/core/widgets/theme_bottom_sheet.dart';
import 'package:myarchapp/features/auth/providers/login_provider.dart';
import 'package:myarchapp/features/settings/providers/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myarchapp/features/settings/providers/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    final languageState = ref.watch(languageProvider);
    final themeState = ref.watch(themeProvider);
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.settings),
      ),
      body: ListView(
        children: [
          _SettingWithBottomSheet(
            icon: Icons.language,
            label: locale.language,
            currentSetting: languageState,
            bottomSheet: const LanguageBottomSheet(),
          ),
          _SettingWithBottomSheet(
            icon: isLightTheme
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
            label: locale.theme,
            currentSetting: themeState.name,
            bottomSheet: const ThemeBottomSheet(),
          ),
          _SettingItem(
            icon: CupertinoIcons.cube_box,
            label: locale.aboutApp,
            subtitle: locale.aboutAppSubtitle,
            route: const AboutAppRoute(),
          ),
          IconButton(
            onPressed: () {
              ref.read(loginProvider.notifier).signOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  const _SettingItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.route,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final String subtitle;
  final PageRouteInfo route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ListTile(
        tileColor: Theme.of(context).cardColor,
        shape: AppShapes.listTileShape,
        leading: Icon(icon),
        title: Text(label),
        subtitle: Text(subtitle),
        onTap: () {
          context.router.push(route);
        },
      ),
    );
  }
}

class _SettingWithBottomSheet extends StatelessWidget {
  const _SettingWithBottomSheet({
    Key? key,
    required this.icon,
    required this.label,
    required this.currentSetting,
    required this.bottomSheet,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final String currentSetting;
  final Widget bottomSheet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ListTile(
        tileColor: Theme.of(context).cardColor,
        shape: AppShapes.listTileShape,
        leading: Icon(icon),
        title: Text(label),
        subtitle: Text(currentSetting),
        onTap: () {
          showModalBottomSheet(
            shape: AppShapes.bottomSheetShape,
            context: context,
            builder: (context) => bottomSheet,
          );
        },
      ),
    );
  }
}
