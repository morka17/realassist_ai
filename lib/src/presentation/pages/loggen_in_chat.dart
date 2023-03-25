import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realassist_ai/src/domain/entities/answer.dart';
import 'package:realassist_ai/src/presentation/provider/chat_provider.dart';
import 'package:realassist_ai/src/presentation/widgets/chat_input_field.dart';
import 'package:realassist_ai/src/presentation/widgets/chat_message_tile.dart';
import 'package:realassist_ai/src/presentation/widgets/drawer_content.dart';

import '../widgets/assistance_message_tile.dart';
import '../widgets/example_questions.dart';
import '../widgets/subscribe_button.dart';

class LoggenInChat extends StatefulWidget {
  const LoggenInChat({super.key});

  @override
  State<LoggenInChat> createState() => _LoggenInChatState();
}

class _LoggenInChatState extends State<LoggenInChat> {
  List<Widget> StackItem = [];

  @override
  Widget build(BuildContext context) {
    var chatProvider = context.watch<ChatProvider>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Drawer(
        child: DrawerContent(),
      ),
      appBar: AppBar(
        toolbarHeight: 70,
        leading: Builder(builder: (context) {
          return SizedBox(
            width: 20,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
          );
        }),
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Real Assist AI",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "This is private message between and your assistant.",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: Container(
        // height: size.height,
        width: size.width,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: size.height - 90,
                width: size.width,
                //    color: Colors.black,
                child: chatProvider.chats.isNotEmpty
                    ? ListView.builder(
                        itemCount: chatProvider.chats.length,
                        itemBuilder: (context, index) {
                          var message = chatProvider.chats[index];
                          bool isUser = message.isUser();
                          double bottom = 0.0;
                          if (chatProvider.chats.length == index + 1) {
                            bottom = 65;
                          }
                          return isUser
                              ? Container(
                                  margin: EdgeInsets.only(
                                    bottom: isUser ? bottom : 0,
                                  ),
                                  child: UserChatMessageTile(
                                    message: message as UserMessage,
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(
                                    bottom: !isUser ? bottom : 0,
                                  ),
                                  child: AssistantChatMessageTile(
                                    message: message as AssistantMessage,
                                  ),
                                );
                        },
                      )
                    : const ExampleQuestions(),
              ),
            ),
            Positioned(
              bottom: 83.0,
              right: 20,
              child: Visibility(
                visible: !chatProvider.subscribed,
                child: const SubscribeButton(),
              ),
            ),
            Positioned(
              bottom: 15,
              child: Container(
                alignment: Alignment.center,
                width: size.width - 20,
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width - 85,
                      height: 55,
                      child: const ChatInputField(),
                    ),
                    const SendButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
