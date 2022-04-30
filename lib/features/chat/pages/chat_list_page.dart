import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/router/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatListPage extends ConsumerWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.chat),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => context.router.push(const ChatRoute()),
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.fromLTRB(3, 3, 3, 0),
              height: 90,
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(locale.chatRoom),
                          const SizedBox(width: 10),
                          const Icon(Icons.chevron_right_rounded)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey[600],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
