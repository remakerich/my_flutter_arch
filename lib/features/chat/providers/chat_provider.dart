import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/injection/injection.dart';
import 'package:myarchapp/features/chat/models/message.dart';
import 'package:myarchapp/features/chat/providers/message_provider.dart';
import 'package:myarchapp/features/chat/providers/user_name_provider.dart';
import 'package:myarchapp/features/chat/services/chat_service.dart';

final chatProvider =
    StateNotifierProvider.autoDispose<ChatNotifier, AsyncValue<List<Message>>>(
  (ref) {
    return ChatNotifier(
      getIt<ChatService>(),
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

  void started() async {
    state = const AsyncLoading();

    final result = await _chatService.subscribeToChat();

    result.when(
      left: (failure) => state = AsyncError(failure),
      right: (subscription) {
        _chatSubscription = subscription.listen(
          (event) {
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
