import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/network/network_config.dart';

@LazySingleton()
class GqlClient {
  static final client = GraphQLClient(
    link: WebSocketLink(
      NetworkConfig.chatWebSocket,
    ),
    cache: GraphQLCache(),
  );

  Future<QueryResult> query(
    String document, {
    Map<String, dynamic> variables = const <String, dynamic>{},
    String? property,
  }) async {
    final Map<String, dynamic> _variables = Map.from(variables);

    final WatchQueryOptions options = WatchQueryOptions(
      document: gql(document),
      variables: _variables,
      fetchPolicy: FetchPolicy.noCache,
    );

    final QueryResult response = await client.query(options);

    if (response.hasException) {
      throw Exception(response.exception);
    }

    return response;
  }

  Future<QueryResult> mutate(
    String document, {
    Map<String, dynamic> variables = const <String, dynamic>{},
    String? property,
  }) async {
    final Map<String, dynamic> _variables = Map.from(variables);

    final MutationOptions options = MutationOptions(
      document: gql(document),
      variables: _variables,
      fetchPolicy: FetchPolicy.noCache,
    );

    final QueryResult response = await client.mutate(options);

    if (response.hasException) {
      throw Exception(response.exception);
    }

    return response;
  }

  Stream<QueryResult> subscribe(
    String document, {
    Map<String, dynamic> variables = const <String, dynamic>{},
    String? property,
  }) {
    final Map<String, dynamic> _variables = Map.from(variables);

    final SubscriptionOptions options = SubscriptionOptions(
      document: gql(document),
      variables: _variables,
      fetchPolicy: FetchPolicy.noCache,
    );

    final Stream<QueryResult> response = client.subscribe(options);

    //TODO: figure out how to catch socket exception

    return response;
  }
}
