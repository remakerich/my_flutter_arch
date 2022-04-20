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

  final GraphQLClient _client;

  Future<QueryResult> getAllMessages() async {
    return await _client.query(
      QueryOptions(
        document: gql(GqlQueries.getAllMessages),
      ),
    );
  }

  Future<void> postMessage(
    String userName,
    String message,
  ) async {
    await _client.mutate(
      MutationOptions(
        document: gql(GqlQueries.postMessage(userName, message)),
      ),
    );
  }

  Stream<QueryResult> subscribeToChat() {
    return _client.subscribe(
      SubscriptionOptions(
        document: gql(
          GqlQueries.subscribe,
        ),
      ),
    );
  }
}
