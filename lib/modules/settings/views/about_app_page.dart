import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/utils/ui.dart';
import 'package:myarchapp/core/l10n/localization.dart';
import 'package:myarchapp/modules/settings/controllers/app_version_provider.dart';

class AboutAppPage extends ConsumerWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    final appVersionState = ref.watch(appVersionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.aboutApp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppShapes.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(locale.appVersion),
            appVersionState.when(
              data: (version) {
                return Text(version);
              },
              error: (error, stackTrace) {
                return Text('$error, $stackTrace');
              },
              loading: () => const CupertinoActivityIndicator(),
            ),
            _SectionHeader(locale.historyOfChanges),
            Text(locale.changelog),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
