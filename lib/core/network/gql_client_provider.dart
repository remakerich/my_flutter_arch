import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_test_new/core/network/network_config.dart';

final gqlClientProvider = Provider(
  (ref) {
    return GraphQLClient(
      link: WebSocketLink(
        NetworkConfig.serverWebSocket,
      ),
      cache: GraphQLCache(),
    );
  },
);
