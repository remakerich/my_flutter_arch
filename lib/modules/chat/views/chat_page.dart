import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/utils/ui.dart';
import 'package:myarchapp/core/widgets/easter_egg.dart';
import 'package:myarchapp/core/widgets/input_field.dart';
import 'package:myarchapp/core/l10n/localization.dart';
import 'package:myarchapp/modules/chat/controllers/chat_provider.dart';
import 'package:myarchapp/modules/chat/controllers/message_provider.dart';
import 'package:myarchapp/modules/chat/controllers/user_name_provider.dart';
import 'package:myarchapp/modules/chat/models/message.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.chatRoom),
      ),
      body: Column(
        children: const [
          Expanded(
            child: _MessagesList(),
          ),
          _InputArea(),
          EasterEgg(),
        ],
      ),
    );
  }
}

class _MessagesList extends ConsumerWidget {
  const _MessagesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatProvider);
    final userName = ref.watch(userNameProvider);

    return state.when(
      data: (messages) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isMe = userName == message.user;

            return _Message(
              isMe: isMe,
              message: message,
            );
          },
        );
      },
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CupertinoActivityIndicator(),
            SizedBox(height: AppShapes.padding),
            Text(
              'Please make sure\nchat server is running.\n\n'
              'Please note: This feature can only\n'
              'be tested on emulator',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Text(
          '$error $stackTrace',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  final bool isMe;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppShapes.padding,
        0,
        AppShapes.padding,
        AppShapes.padding,
      ),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...{
            Text(
              '${message.user}:',
            ),
            const SizedBox(width: AppShapes.padding),
          },
          Container(
            padding: const EdgeInsets.all(AppShapes.padding),
            decoration: BoxDecoration(
              color: isMe ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(AppShapes.borderRadius),
            ),
            child: Row(
              children: [
                Text(
                  message.content,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InputArea extends ConsumerWidget {
  const _InputArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageNotifier = ref.watch(messageProvider.notifier);
    final locale = AppLocalizations.of(context)!;

    return SafeArea(
      child: Row(
        children: [
          const SizedBox(width: AppShapes.padding),
          Expanded(
            flex: 1,
            child: AppInputField(
              hint: locale.name,
              onChanged: (userName) {
                ref.read(userNameProvider.notifier).state = userName;
              },
            ),
          ),
          const SizedBox(width: AppShapes.padding),
          Expanded(
            flex: 2,
            child: AppInputField(
              hint: locale.message,
              controller: messageNotifier.messageController,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(AppShapes.padding),
            child: GestureDetector(
              child: const Icon(
                Icons.keyboard_double_arrow_up_rounded,
              ),
              onTap: () {
                ref.read(chatProvider.notifier).messagePosted();
              },
            ),
          )
        ],
      ),
    );
  }
}
