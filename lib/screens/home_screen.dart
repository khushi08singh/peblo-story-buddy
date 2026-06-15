import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/quiz_model.dart';
import '../providers/story_provider.dart';
import '../utils/constants.dart';
import '../widgets/buddy_character.dart';
import '../widgets/story_card.dart';
import '../widgets/quiz_card.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StoryProvider>(context);

    final quiz =
    QuizModel.fromJson(AppConstants.quizJson);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F3FF),
      appBar: AppBar(
        title: const Text("Peblo Story Buddy"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            BuddyCharacter(
              isHappy: provider.isSuccess,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: provider.isLoading
                    ? null
                    : () async {
                  await provider.readStory();
                },
                child: provider.isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                  "Read Me a Story",
                ),
              ),
            ),

            const SizedBox(height: 25),

            const StoryCard(
              storyText: AppConstants.storyText,
            ),

            const SizedBox(height: 20),

            if (provider.feedbackMessage != null)
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: provider.isSuccess
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  provider.feedbackMessage!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            if (provider.showQuiz)
              QuizCard(
                quiz: quiz,
                onAnswerSelected: (answer) {
                  provider.checkAnswer(answer);

                  if (!provider.isSuccess) {
                    HapticFeedback.mediumImpact();
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}