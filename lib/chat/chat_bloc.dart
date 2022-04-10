import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_test_new/services/chat_service.dart';
import 'package:injectable/injectable.dart';

import '../models/message.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatInitial()) {
    on<ChatStarted>(_started);
    on<ChatSynced>(_handleSync);
    on<ChatMessagePosted>(_handleMessagePosted);
  }

  StreamSubscription? _chatSubscription;

  @override
  Future<void> close() async {
    await _chatSubscription?.cancel();
    return super.close();
  }

  Future<void> _handleMessagePosted(
    ChatMessagePosted event,
    Emitter<ChatState> emit,
  ) async {
    ChatService.postMessage(event.user, event.content);
  }

  Future<void> _handleSync(
    ChatSynced event,
    Emitter<ChatState> emit,
  ) async {
    emit(const ChatLoading());

    emit(ChatSuccess(event.messages));
  }

  void _started(
    ChatStarted event,
    Emitter<ChatState> emit,
  ) {
    emit(const ChatLoading());

    _chatSubscription = ChatService.subscribeToChat().listen(
      (event) {
        final messages = <Message>[];
        event.data!['messages'].forEach((message) {
          final parsedMessage = Message.fromJson(message);
          messages.add(parsedMessage);
        });
        add(ChatSynced(messages));
      },
    );
  }
}
