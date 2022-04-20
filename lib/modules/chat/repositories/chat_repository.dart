import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_test_new/core/network/gql_client_provider.dart';
import 'package:graphql_test_new/modules/chat/repositories/queries.dart';

final chatRepository = Provider<ChatRepository>(
  (ref) {
    return ChatRepository(
      ref.watch(gqlClientProvider),
    );
  },
);

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
