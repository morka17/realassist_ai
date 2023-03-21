import 'package:dart_openai/openai.dart';

abstract class ChatRepository {

  Stream<OpenAIStreamChatCompletionModel> getAnserFromOpenAI(String question);
   
}
