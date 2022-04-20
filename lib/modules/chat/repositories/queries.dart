class GqlQueries {
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