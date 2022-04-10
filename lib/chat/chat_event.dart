part of 'chat_bloc.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.started() = ChatStarted;

  const factory ChatEvent.synced(
    List<Message> messages,
  ) = ChatSynced;

  const factory ChatEvent.messagePosted({
    required String user,
    required String content,
  }) = ChatMessagePosted;
}
