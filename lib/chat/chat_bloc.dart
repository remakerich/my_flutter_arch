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
    on<ChatUserNameChanged>(_handleUserNameChanged);
  }

  StreamSubscription? _chatSubscription;
  String _userName = '';
  List<Message> _messages = [];

  @override
  Future<void> close() async {
    await _chatSubscription?.cancel();
    return super.close();
  }

  Future<void> _handleUserNameChanged(
    ChatUserNameChanged event,
    Emitter<ChatState> emit,
  ) async {
    emit(const ChatLoading());

    _userName = event.userName;

    emit(
      ChatSuccess(
        messages: _messages,
        userName: _userName,
      ),
    );
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

    _messages = event.messages.reversed.toList();

    emit(
      ChatSuccess(
        messages: _messages,
        userName: _userName,
      ),
    );
  }

  void _started(
    ChatStarted event,
    Emitter<ChatState> emit,
  ) {
    emit(const ChatLoading());

    _chatSubscription = ChatService.subscribeToChat().listen(
      (event) {
        final messages = <Message>[];
        event.data!['messages'].forEach(
          (message) {
            final parsedMessage = Message.fromJson(message);
            messages.add(parsedMessage);
          },
        );
        add(ChatSynced(messages));
      },
    );
  }
}
