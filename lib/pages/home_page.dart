import 'package:flutter/material.dart';
import 'package:graphql_test_new/services/chat_service.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GraphQL chat + Riverpod',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: ChatService.subscribeToChat(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Text(snapshot.data!.toString());
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ChatService.postMessage('Vasya', 'test');
            },
            child: Text(
              'Send message',
            ),
          )
        ],
      ),
    );
  }
}
