import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:realassist_ai/src/domain/entities/answer.dart';

class UserChatMessageTile extends StatelessWidget {
  const UserChatMessageTile({super.key, required this.message});

  final UserMessage message;

  @override
  Widget build(BuildContext context) {
    var f = DateFormat('hh:mm a');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      color: message.metaData.userId == "user"
          ? Colors.white
          : const Color(0XFFFAFAFC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.data,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 15, color: Colors.black),
          ),
          const SizedBox(height: 10),
          Text(
            f.format(
              message.metaData.createdTime,
            ),
            style:
                Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12),
          )
        ],
      ),
    );
  }
}
