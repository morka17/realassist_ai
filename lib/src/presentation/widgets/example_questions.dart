import 'package:flutter/material.dart';
import 'package:realassist_ai/src/presentation/widgets/example_question_tile.dart';

class ExampleQuestions extends StatefulWidget {
  const ExampleQuestions({super.key});

  @override
  State<ExampleQuestions> createState() => _ExampleQuestionsState();
}

class _ExampleQuestionsState extends State<ExampleQuestions> {
  final List<String> exampleQuestions = [
    "Create a blog content specific real estate",
    "Create a blog content specific real estate",
    "Create email drip campaign content for your clients",
    "Writing answers to your clients",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 28),
            Text(
              "Example of questions to ask RealAssist",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20),
            for (final question in exampleQuestions)
              ExampleQuestionTile(
                question: question,
              ),
          ],
        ),
      ),
    );
  }
}
