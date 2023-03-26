import 'package:dart_openai/src/core/models/chat/stream/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:realassist_ai/src/data/datasource/chat_api_services.dart';
import 'package:realassist_ai/src/data/models/answer.dart';
import 'package:realassist_ai/src/domain/entities/answer.dart';
import 'package:realassist_ai/src/domain/usecases/get_answer_from_openai.dart';

class ChatProvider extends ChangeNotifier {
  int messageCount = -1;

  bool _subscribed = false;

  TextEditingController _editingController = TextEditingController();
  ScrollController? _scrollController;

  ScrollController? get scrollController => _scrollController;

  TextEditingController get editingController {
    return _editingController;
  }

  bool get subscribed => _subscribed;

  set editingController(value) {
    _editingController = value;
    notifyListeners();
  }

  set scrollController(value) {
    _scrollController = value;
    notifyListeners();
  }

  set subscribed(value) {
    _subscribed = value;
    notifyListeners();
  }

  List<Message> _chats = [];

  List<Message> get chats => _chats;

  set chats(value) {
    _chats = value;
    notifyListeners();
  }

  void sendMessage(String question) {
    var metaData = MessageMetaData(
      userId: "user",
      createdTime: DateTime.now(),
    );
    var message = UserMessage(
      id: (++messageCount).toString(),
      data: question,
      metaData: metaData,
    );

    _chats.add(message);
    _editingController.clear();

    notifyListeners();

    retriveChat(question);
  }

  void retriveChat(String question) async {
    final chatApiServices = ChatApiServices();

    final getAnswer = GetAnswer(chatApiServices);

    final chatStreamResult = getAnswer(question);

    //print(chatStream);

    chatStreamResult.fold((l) {
      // Get.snackbar("Error", "unexpected error",
      //     borderColor: const Color(0XFFFF0000));
    }, (chatStream) {
      final metaData = MessageMetaData(
        userId: "assistant",        
        createdTime: DateTime.now(),
      );

      final chat = AssistantMessage(
        id: (++messageCount).toString(),
        chatStream: chatStream,
        metaData: metaData,
      );

      _chats.add(chat);
    });

    notifyListeners();
  }
}
