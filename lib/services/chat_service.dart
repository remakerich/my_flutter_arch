import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ChatService {
  const ChatService();

  static get _url => Platform.isAndroid ? 'ws://10.0.2.2:4000' : 'ws://localhost:4000';

  static final _client = GraphQLClient(
    link: WebSocketLink(_url),
    cache: GraphQLCache(),
  );

  Future<QueryResult> getAllMessages() async {
    return await _client.query(
      QueryOptions(
        document: gql(GqlDocs.getAllMessages),
      ),
    );
  }

  Future<QueryResult> postMessage(
    String userName,
    String message,
  ) async {
    return await _client.mutate(
      MutationOptions(
        document: gql(GqlDocs.postMessage(userName, message)),
      ),
    );
  }

  Stream<QueryResult> subscribeToChat() {
    return _client.subscribe(
      SubscriptionOptions(
        document: gql(
          GqlDocs.subscribe,
        ),
      ),
    );
  }
}

class GqlDocs {
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
