import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/failure.dart';
import 'package:myarchapp/core/exceptions/handle_exceptions.dart';
import 'package:myarchapp/modules/chat/data/chat_repository.dart';

@LazySingleton()
class ChatService {
  const ChatService(
    this._chatRepository,
  );

  final ChatRepository _chatRepository;

  Future<Either<Failure, QueryResult>> getAllMessages() {
    return handleExceptions(
      () => _chatRepository.getAllMessages(),
    );
  }

  Future<Either<Failure, QueryResult>> postMessage(
    String userName,
    String message,
  ) {
    return handleExceptions(
      () => _chatRepository.postMessage(userName, message),
    );
  }

  Either<Failure, Stream<QueryResult<Object?>>> subscribeToChat() {
    try {
      final result = _chatRepository.subscribeToChat();
      return Right(result);
    } catch (exception) {
      return Left(Failure.fromException(exception));
    }
  }
}
