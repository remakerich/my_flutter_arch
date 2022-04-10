import 'package:flutter/cupertino.dart';
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
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'GraphQL chat + Riverpod',
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                buildWhen: (_, state) => state is ChatSuccess,
                builder: (context, state) {
                  return state.maybeWhen(
                    success: (messages) {
                      return ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          return Text('${message.id} ${message.user} ${message.content}');
                        },
                      );
                    },
                    orElse: () => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                },
              ),
            ),
            Builder(
              builder: (context) {
                return Container(
                  color: Colors.green,
                  child: ElevatedButton(
                    child: Text('postMessage'),
                    onPressed: () {
                      final event = ChatMessagePosted(user: 'Petya', content: 'Test from Pertya');
                      context.read<ChatBloc>().add(event);
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
