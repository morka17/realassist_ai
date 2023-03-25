import 'dart:async';

import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:realassist_ai/src/domain/entities/answer.dart';
import 'package:realassist_ai/src/presentation/provider/chat_provider.dart';

class AssistantChatMessageTile extends StatefulWidget {
  const AssistantChatMessageTile({super.key, required this.message});

  final AssistantMessage message;

  @override
  State<AssistantChatMessageTile> createState() =>
      _AssistantChatMessageTileState();
}

class _AssistantChatMessageTileState extends State<AssistantChatMessageTile> {
  @override
  void initState() {
    retrieveStreamContent();
    super.initState();
  }

  StreamSubscription<OpenAIStreamChatCompletionModel>? subscription = null;

  String data = "";

  final _dataKey = GlobalKey();

  bool _isLoading = true;

  void retrieveStreamContent() async {
    subscription = widget.message.chatStream.listen((chat) {
      for (var choice in chat.choices) {
        print(choice);
        _isLoading = false;
        var content = choice.delta.content;
        print(content);
        setState(() {
          data += (content ?? "");
        });
      }

      Scrollable.ensureVisible(context);
    });

    subscription?.onError((_) {
      Get.snackbar("Error", "Unexpected error, try again",
          borderColor: const Color(0XFFFF0000));
    });

    subscription?.onDone(() {
      subscription?.cancel();
    });

    //widget.message.chatStream
  }

  @override
  Widget build(BuildContext context) {
    var f = DateFormat('hh:mm a');

    if (_isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 100,
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: SpinKitThreeBounce(
              size: 35,
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.black54 : Colors.black38,
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      color: widget.message.metaData.userId == "user"
          ? Colors.white
          : const Color(0XFFFAFAFC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.trimLeft(),
            key: _dataKey,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 10),
          Text(
            f.format(
              widget.message.metaData.createdTime,
            ),
            style:
                Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12),
          )
        ],
      ),
    );
  }
}
