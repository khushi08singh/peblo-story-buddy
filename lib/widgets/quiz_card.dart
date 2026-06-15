import 'package:flutter/material.dart';
import '../models/quiz_model.dart';

class QuizCard extends StatelessWidget {
  final QuizModel quiz;
  final Function(String) onAnswerSelected;

  const QuizCard({
    super.key,
    required this.quiz,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              quiz.question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ...quiz.options.map(
                  (option) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      onAnswerSelected(option);
                    },
                    child: Text(option),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}