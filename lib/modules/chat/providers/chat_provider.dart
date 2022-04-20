import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_test_new/modules/chat/models/message.dart';
import 'package:graphql_test_new/modules/chat/providers/message_provider.dart';
import 'package:graphql_test_new/modules/chat/providers/user_name_provider.dart';
import 'package:graphql_test_new/modules/chat/services/chat_service.dart';

final chatProvider =
    StateNotifierProvider.autoDispose<ChatNotifier, AsyncValue<List<Message>>>(
  (ref) {
    return ChatNotifier(
      ref.watch(chatService),
      ref,
    );
  },
);

class ChatNotifier extends StateNotifier<AsyncValue<List<Message>>> {
  ChatNotifier(
    this._chatService,
    this._ref,
  ) : super(const AsyncLoading()) {
    started();
  }

  StreamSubscription? _chatSubscription;
  List<Message> _messages = [];
  final ChatService _chatService;
  final Ref _ref;

  @override
  Future<void> dispose() async {
    await _chatSubscription?.cancel();
    return super.dispose();
  }

  void started() {
    state = const AsyncLoading();

    final result = _chatService.subscribeToChat();

    result.when(
      left: (failure) => AsyncError(failure),
      right: (subscription) {
        _chatSubscription = subscription.listen(
          (event) {
            print('event $event');
            final messages = <Message>[];
            event.data!['messages'].forEach(
              (message) => messages.add(
                Message.fromJson(message),
              ),
            );

            _messages = messages.reversed.toList();

            state = AsyncData(_messages);
          },
        );
      },
    );
  }

  void messagePosted() async {
    final message = _ref.read(messageProvider);
    final userName = _ref.read(userNameProvider);
    final result = await _chatService.postMessage(userName, message);

    result.when(
      left: (failure) => state = AsyncError(failure),
      right: (_) => _ref.read(messageProvider.notifier).clear(),
    );
  }
}
