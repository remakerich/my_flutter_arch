import 'package:graphql_flutter/graphql_flutter.dart';

class ChatService {
  static const _serverUrl = 'http://10.0.2.2:4000';

  static final _client = GraphQLClient(
    link: HttpLink(_serverUrl),
    cache: GraphQLCache(),
  );

  static Future<QueryResult> getAllMessages() async {
    return await _client.query(
      QueryOptions(
        document: gql(GQLqueries.getAllMessages),
      ),
    );
  }

  static Future<QueryResult> postMessage(
    String userName,
    String message,
  ) async {
    return await _client.mutate(
      MutationOptions(
        document: gql(GQLqueries.postMessage(userName, message)),
      ),
    );
  }
}

class GQLqueries {
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
}
