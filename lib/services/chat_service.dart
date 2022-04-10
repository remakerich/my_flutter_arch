import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';

class ChatService {
  static get _serverWebSocket {
    late final String hostname;

    if (Platform.isAndroid) {
      hostname = '10.0.2.2';
    } else {
      hostname = 'localhost';
    }

    return 'ws://$hostname:4000';
  }

  static final _client = GraphQLClient(
    link: WebSocketLink(_serverWebSocket),
    cache: GraphQLCache(),
  );

  static Future<QueryResult> getAllMessages() async {
    return await _client.query(
      QueryOptions(
        document: gql(GQLdocs.getAllMessages),
      ),
    );
  }

  static Future<QueryResult> postMessage(
    String userName,
    String message,
  ) async {
    return await _client.mutate(
      MutationOptions(
        document: gql(GQLdocs.postMessage(userName, message)),
      ),
    );
  }

  static Stream<QueryResult> subscribeToChat() {
    return _client.subscribe(
      SubscriptionOptions(
        document: gql(
          GQLdocs.subscribe,
        ),
      ),
    );
  }
}

class GQLdocs {
  static const getAllMessages = '''
    query { 
      messages { 
        id 
        content 
        user 
      } 
    }
  ''';

  static String postMessage(String userName, String message) => '''
    mutation {
      postMessage(user: "$userName", content: "$message")
    }
  ''';

  static const subscribe = '''
    subscription { 
      messages { 
        id 
        content 
        user 
      } 
    }
  ''';
}
