import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/network/gql_client.dart';
import 'package:myarchapp/features/chat/repositories/queries.dart';

@LazySingleton()
class ChatRepository {
  const ChatRepository(
    this._client,
  );

  final GqlClient _client;

  Future<QueryResult> getAllMessages() async {
    return await _client.query(GqlQueries.getAllMessages);
  }

  Future<QueryResult> postMessage(
    String userName,
    String message,
  ) async {
    return await _client.mutate(
      GqlQueries.postMessage(userName, message),
    );
  }

  Stream<QueryResult> subscribeToChat() {
    return _client.subscribe(GqlQueries.subscribe);
  }
}
