import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_test_new/injection/injection.dart';
import 'package:graphql_test_new/providers/chat/chat_notifier.dart';
import 'package:graphql_test_new/providers/chat/chat_state.dart';

final chatNotifierProvider = StateNotifierProvider<ChatNotifier, ChatState>(
  (ref) => getIt<ChatNotifier>()..started(),
);
