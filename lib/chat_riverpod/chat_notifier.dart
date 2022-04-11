import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_test_new/chat_riverpod/chat_state.dart';
import 'package:graphql_test_new/models/message.dart';
import 'package:graphql_test_new/services/chat_service.dart';

final chatNotifierProvider = StateNotifierProvider<ChatNotifier, ChatState>(
  (ref) => ChatNotifier()..started(),
);

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(const ChatState.initial());

  StreamSubscription? _chatSubscription;
  String _userName = '';
  List<Message> _messages = [];
  final userNameController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Future<void> dispose() async {
    await _chatSubscription?.cancel();
    userNameController.dispose();
    messageController.dispose();
    return super.dispose();
  }

  void started() {
    state = const ChatState.loading();

    _chatSubscription = ChatService.subscribeToChat().listen(
      (event) {
        final messages = <Message>[];
        event.data!['messages'].forEach(
          (message) {
            final parsedMessage = Message.fromJson(message);
            messages.add(parsedMessage);
          },
        );

        _messages = messages.reversed.toList();

        state = ChatState.success(
          messages: _messages,
          userName: _userName,
        );
      },
    );
  }

  void userNameChanged() {
    _userName = userNameController.text;

    state = ChatState.success(
      messages: _messages,
      userName: _userName,
    );
  }

  void messagePosted() {
    ChatService.postMessage(
      userNameController.text,
      messageController.text,
    );
    messageController.clear();
  }
}
