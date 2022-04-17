import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_test_new/injection/injection.dart';
import 'package:graphql_test_new/models/chat.dart';
import 'package:graphql_test_new/models/message.dart';
import 'package:graphql_test_new/services/chat_service.dart';
import 'package:injectable/injectable.dart';

final chatNotifierProvider = StateNotifierProvider<ChatNotifier, AsyncValue<Chat>>(
  (ref) => getIt<ChatNotifier>()..started(ref)
);

@injectable
class ChatNotifier extends StateNotifier<AsyncValue<Chat>> {
  ChatNotifier(
    this._chatService,
  ) : super(const AsyncLoading());

  StreamSubscription? _chatSubscription;
  String _userName = '';
  List<Message> _messages = [];
  final userNameController = TextEditingController();
  final messageController = TextEditingController();
  final ChatService _chatService;
  late final Ref _ref;

  @override
  Future<void> dispose() async {
    await _chatSubscription?.cancel();
    userNameController.dispose();
    messageController.dispose();
    return super.dispose();
  }

  void started(Ref ref) {
    _ref = ref;
    state = const AsyncLoading();

    _chatSubscription = _chatService.subscribeToChat().listen(
      (event) {
        final messages = <Message>[];
        event.data!['messages'].forEach(
          (message) {
            final parsedMessage = Message.fromJson(message);
            messages.add(parsedMessage);
          },
        );

        _messages = messages.reversed.toList();

        state = AsyncData(Chat(
          messages: _messages,
          userName: _userName,
        ));
      },
    );
  }

  void userNameChanged() {
    _userName = userNameController.text;

    state = state = AsyncData(Chat(
      messages: _messages,
      userName: _userName,
    ));
  }

  void messagePosted() {
    _chatService.postMessage(
      userNameController.text,
      messageController.text,
    );
    messageController.clear();
  }
}
