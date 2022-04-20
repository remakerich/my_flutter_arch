import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageProvider =
    StateNotifierProvider.autoDispose<MessageNotifier, String>(
  (ref) => MessageNotifier(),
);

class MessageNotifier extends StateNotifier<String> {
  MessageNotifier() : super('') {
    started();
  }

  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    return super.dispose();
  }

  void started() {
    messageController.addListener(_listener);
  }

  void clear() {
    messageController.clear();
  }

  void _listener() {
    state = messageController.text;
  }
}
