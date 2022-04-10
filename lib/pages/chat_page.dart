import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_test_new/chat/chat_bloc.dart';
import 'package:graphql_test_new/injection/injection.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ChatBloc>()..add(const ChatStarted()),
        ),
      ],
      child: Scaffold(
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
      ),
    );
  }
}

class _MessagesList extends StatelessWidget {
  const _MessagesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (_, state) => state is ChatSuccess,
      builder: (context, state) {
        return state.maybeMap(
          success: (state) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              reverse: true,
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                final message = state.messages[index];
                final isMe = state.userName == message.user;

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
      },
    );
  }
}

class _InputArea extends StatefulWidget {
  const _InputArea({Key? key}) : super(key: key);

  @override
  State<_InputArea> createState() => _InputAreaState();
}

class _InputAreaState extends State<_InputArea> {
  final _userNameController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: _TextField(
                hint: 'Username',
                controller: _userNameController,
              ),
            ),
            Expanded(
              flex: 2,
              child: _TextField(
                hint: 'Message',
                controller: _messageController,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: GestureDetector(
                child: const Icon(
                  Icons.keyboard_double_arrow_up_rounded,
                ),
                onTap: () {
                  final event = ChatMessagePosted(
                    user: _userNameController.text,
                    content: _messageController.text,
                  );
                  context.read<ChatBloc>().add(event);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    Key? key,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
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
          final event = ChatUserNameChanged(value);
          context.read<ChatBloc>().add(event);
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
