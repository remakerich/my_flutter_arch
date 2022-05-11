import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/router/router.dart';
import 'package:myarchapp/core/utils/ui.dart';
import 'package:myarchapp/core/l10n/localization.dart';

class ChatListPage extends ConsumerWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          itemCount: 1,
          itemBuilder: (context, index) {
            return ListTile(
                trailing: const Icon(Icons.chevron_right),
                tileColor: Theme.of(context).cardColor,
                shape: AppShapes.listTileShape,
                leading: const Icon(Icons.people),
                title: Text(locale.chatRoom),
                onTap: () => context.router.push(const ChatRoute()));
          },
        ),
      ),
    );
  }
}
