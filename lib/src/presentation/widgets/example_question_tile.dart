import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realassist_ai/src/domain/entities/answer.dart';
import 'package:realassist_ai/src/presentation/provider/chat_provider.dart';

class ExampleQuestionTile extends StatelessWidget {
  const ExampleQuestionTile({super.key, required this.question});

  final String question;

  @override
  Widget build(BuildContext context) {
    var chatProvider = context.read<ChatProvider>();

    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          chatProvider.sendMessage(question);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width - 120,
              child: Text(
                question,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const Icon(
              Icons.arrow_right,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
