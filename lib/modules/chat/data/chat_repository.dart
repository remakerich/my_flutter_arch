import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/injection/gql_client.dart';
import 'package:myarchapp/modules/chat/data/queries.dart';

@LazySingleton()
class ChatRepository {
  const ChatRepository(
    this._client,
  );

  final GqlClient _client;

  Future<QueryResult> getAllMessages() async {
    return await _client.query(ChatScheme.getAllMessages);
  }

  Future<QueryResult> postMessage(
    String userName,
    String message,
  ) async {
    return await _client.mutate(
      ChatScheme.postMessage(userName, message),
    );
  }

  Stream<QueryResult> subscribeToChat() {
    return _client.subscribe(ChatScheme.subscribe);
  }
}
