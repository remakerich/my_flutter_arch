part of 'chat_bloc.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.initial() = ChatInitial;

  const factory ChatState.loading() = ChatLoading;

  const factory ChatState.failure() = ChatFailure;

  const factory ChatState.success({
    required List<Message> messages,
    required String userName,
  }) = ChatSuccess;
}
