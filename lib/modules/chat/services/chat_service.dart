import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_test_new/core/models/either.dart';
import 'package:graphql_test_new/core/models/failure.dart';
import 'package:graphql_test_new/modules/chat/repositories/chat_repository.dart';

final chatService = Provider<ChatService>(
  (ref) {
    return ChatService(
      ref.watch(chatRepository),
    );
  },
);

class ChatService {
  const ChatService(
    this._chatRepository,
  );

  final ChatRepository _chatRepository;

  Future<Either<Failure, QueryResult>> getAllMessages() async {
    try {
      final result = await _chatRepository.getAllMessages();
      return Right(result);
    } catch (exception) {
      return Left(Failure.fromException(exception));
    }
  }

  Future<Either<Failure, void>> postMessage(
    String userName,
    String message,
  ) async {
    try {
      await _chatRepository.postMessage(userName, message);
      return const Right(null);
    } catch (exception) {
      return Left(Failure.fromException(exception));
    }
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
