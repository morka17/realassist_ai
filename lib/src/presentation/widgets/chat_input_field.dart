import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realassist_ai/src/presentation/provider/chat_provider.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 5,
      onFieldSubmitted: (value) {
        var question = context.read<ChatProvider>().editingController.text;
        if (question.isNotEmpty) {
          context.read<ChatProvider>().sendMessage(question);
        }
      },
      controller: context.read<ChatProvider>().editingController,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
        hintText: "what can I assist you with?",
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  const SendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0XFF304CEF),
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(14),
      ),
      onPressed: () {
        var question = context.read<ChatProvider>().editingController.text;
        if (question.isNotEmpty) {
          context.read<ChatProvider>().sendMessage(question);
        }
      },
      child: const Icon(Icons.send),
    );
  }
}
