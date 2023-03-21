import 'package:dart_openai/src/core/models/chat/stream/chat.dart';
import 'package:dartz/dartz.dart';

import 'package:realassist_ai/src/domain/repositories/chats_repository.dart';

import '../../core/failure.dart';

class GetAnswer {
  final ChatRepository repository;

  GetAnswer(this.repository);

  Either<Failure, Stream<OpenAIStreamChatCompletionModel>> call(
      String question) {
    try {
      return Right(repository.getAnserFromOpenAI(question));
    } catch (e) {
      return Left(Failure(msg: "Network error: $e", code: 404));
    }
  }
}
