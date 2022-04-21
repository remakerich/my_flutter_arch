import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_test_new/core/utils/ui.dart';
import 'package:graphql_test_new/features/chat/pages/chat_page.dart';

class ChatListPage extends ConsumerWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.accent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'GraphQL + WebSocket',
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ChatPage(),
              ),
            ),
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
                        children: const [
                          Text('Chat room'),
                          SizedBox(width: 10),
                          Icon(Icons.chevron_right_rounded)
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
