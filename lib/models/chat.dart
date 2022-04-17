import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_test_new/models/message.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    @Default([]) List<Message> messages,
    @Default('') String userName,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
