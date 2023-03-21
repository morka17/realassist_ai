import 'package:flutter/material.dart';
import 'package:realassist_ai/src/presentation/widgets/subscribe_dialog.dart';

class SubscribeButton extends StatelessWidget {
  const SubscribeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 13),
        backgroundColor: const Color(0XFF262580),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () => showSubscribeDialog(context),
      child: const Text(
        "Subscribe",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
