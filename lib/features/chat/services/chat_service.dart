import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_test_new/core/exceptions/either.dart';
import 'package:graphql_test_new/core/exceptions/exception_handler.dart';
import 'package:graphql_test_new/core/exceptions/failure.dart';
import 'package:graphql_test_new/features/chat/repositories/chat_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ChatService {
  const ChatService(
    this._chatRepository,
  );

  final ChatRepository _chatRepository;

  Future<Either<Failure, QueryResult>> getAllMessages() async {
    return await catchException(
      () => _chatRepository.getAllMessages(),
    );
  }

  Future<Either<Failure, void>> postMessage(
    String userName,
    String message,
  ) async {
    return await catchException(
      () => _chatRepository.postMessage(userName, message),
    );
  }

  Future<Either<Failure, Stream<QueryResult<Object?>>>>
      subscribeToChat() async {
    return await catchException(
      () async => _chatRepository.subscribeToChat(),
    );
  }
}
