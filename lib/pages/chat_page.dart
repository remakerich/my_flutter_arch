import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_test_new/providers/chat_provider.dart';

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
          'GraphQL chat + Riverpod',
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

    return state.maybeMap(
      data: (state) {
        final chat = state.value;

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          reverse: true,
          itemCount: chat.messages.length,
          itemBuilder: (context, index) {
            final message = chat.messages[index];
            final isMe = chat.userName == message.user;

            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Row(
                mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
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
          },
        );
      },
      orElse: () => const Center(
        child: Text('Loading chat'),
      ),
    );
  }
}

class _InputArea extends ConsumerWidget {
  const _InputArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatNotifier = ref.watch(chatProvider.notifier);

    return Container(
      color: Colors.blueGrey,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: _TextField(
                hint: 'Username',
                controller: chatNotifier.userNameController,
              ),
            ),
            Expanded(
              flex: 2,
              child: _TextField(
                hint: 'Message',
                controller: chatNotifier.messageController,
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
      ),
    );
  }
}

class _TextField extends ConsumerWidget {
  const _TextField({
    Key? key,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: TextField(
        onChanged: (value) {
          if (hint != 'Username') {
            return;
          }
          ref.read(chatProvider.notifier).userNameChanged();
        },
        cursorColor: Colors.black,
        cursorWidth: 1,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        obscureText: false,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 10),
          isCollapsed: true,
        ),
      ),
    );
  }
}
