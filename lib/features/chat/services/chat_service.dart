import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:myarchapp/core/exceptions/either.dart';
import 'package:myarchapp/core/exceptions/exception_handler.dart';
import 'package:myarchapp/core/exceptions/failure.dart';
import 'package:myarchapp/features/chat/repositories/chat_repository.dart';

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
