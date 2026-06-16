import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/quiz_model.dart';
import '../providers/story_provider.dart';
import '../utils/constants.dart';
import '../widgets/buddy_character.dart';
import '../widgets/story_card.dart';
import '../widgets/quiz_card.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StoryProvider>(context);

    final quiz =
    QuizModel.fromJson(AppConstants.quizJson);

    return Scaffold(
      // backgroundColor: const Color(0xFFF7F3FF),
      appBar: AppBar(
        title: const Text("Peblo Story Buddy"),
        centerTitle: true,
      ),
      // body: SingleChildScrollView(
      // body: Stack(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF1E8FF),
                Color(0xFFCFBEEA),
                Color(0xFFABC8F1),
              ],
            ),
          ),
          child: Stack(
        children: [
        Align(
        alignment: Alignment.topCenter,
        child: ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
        ),
      ),

      SingleChildScrollView(
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B61FF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: provider.isLoading
                    ? null
                    : () async {
                  await provider.readStory();
                },
                child: provider.isLoading
                    ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  ),
                )
                // const CircularProgressIndicator()

                    : const Text(
                  "Read Me a Story",
                ),
              ),
            ),

            const SizedBox(height: 25),

            const StoryCard(
              storyText: AppConstants.storyText,
            ),
            if (provider.errorMessage != null)
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  provider.errorMessage!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                  // provider.checkAnswer(answer);
                  //
                  // if (!provider.isSuccess) {
                  //   HapticFeedback.mediumImpact();
                  // }
                  provider.checkAnswer(answer);

                  if (provider.isSuccess) {
                    _confettiController.play();
                  } else {
                    HapticFeedback.mediumImpact();
                  }
                },
              ),
          ],
        ),
      ),
      ],
      ),
        ),
    );

  }
}