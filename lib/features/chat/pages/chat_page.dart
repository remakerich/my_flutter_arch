import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_test_new/core/widgets/text_input_field.dart';
import 'package:graphql_test_new/features/chat/models/message.dart';
import 'package:graphql_test_new/features/chat/providers/chat_provider.dart';
import 'package:graphql_test_new/features/chat/providers/message_provider.dart';
import 'package:graphql_test_new/features/chat/providers/user_name_provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'GraphQL + WebSocket',
        ),
      ),
      body: Column(
        children: const [
          Expanded(
            child: _MessagesList(),
          ),
          _InputArea()
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
            SizedBox(height: 10),
            Text(
              'Please make sure\nchat server is running.',
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
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...{
            Text(
              '${message.user}:',
            ),
            const SizedBox(width: 10),
          },
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isMe ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(12),
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

    return SafeArea(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextInputField(
              hint: 'Username',
              onChanged: (userName) {
                ref.read(userNameProvider.notifier).state = userName;
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: TextInputField(
              hint: 'Message',
              controller: messageNotifier.messageController,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
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
