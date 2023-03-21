import 'dart:io';

import 'package:realassist_ai/src/domain/repositories/chats_repository.dart';
import 'package:dart_openai/openai.dart';

class ChatApiServices extends ChatRepository {
  @override
  Stream<OpenAIStreamChatCompletionModel> getAnserFromOpenAI(String question) {
    OpenAI.apiKey = "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";

    try {
      return OpenAI.instance.chat.createStream(
        model: "gpt-3.5-turbo",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: question,
            role: "user",
          )
        ],
      );
    } on SocketException catch(e) {
      throw "Network connection error: $e";
    } catch (e) {
      throw "unexpected error";
    }
  }

// OpenAIStreamChatCompletionModel chatStream = OpenAI.instance.chat.createStream(
//     model: "gpt-3.5-turbo",
//     messages: [
//       OpenAIChatCompletionChoiceMessageModel(
//         content: "hello",
//         role: "user",
//       )
//     ],
//   );

// chatStream.listen((chatStreamEvent) {
// print(chatStreamEvent); // ...
//   })
}
