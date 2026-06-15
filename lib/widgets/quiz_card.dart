// import 'package:flutter/material.dart';
// import '../models/quiz_model.dart';
//
// class QuizCard extends StatelessWidget {
//   final QuizModel quiz;
//   final Function(String) onAnswerSelected;
//
//   const QuizCard({
//     super.key,
//     required this.quiz,
//     required this.onAnswerSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 8,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               quiz.question,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             ...quiz.options.map(
//                   (option) => Padding(
//                 padding: const EdgeInsets.only(bottom: 12),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       onAnswerSelected(option);
//                     },
//                     child: Text(option),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/quiz_model.dart';
import '../providers/story_provider.dart';

class QuizCard extends StatefulWidget {
  final QuizModel quiz;
  final Function(String) onAnswerSelected;

  const QuizCard({
    super.key,
    required this.quiz,
    required this.onAnswerSelected,
  });

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provider =
    Provider.of<StoryProvider>(context);

    if (provider.shouldShake) {
      _controller.forward(from: 0);

      Future.delayed(
        const Duration(milliseconds: 500),
            () {
          provider.shouldShake = false;
        },
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final offset =
            sin(_controller.value * 8 * pi) * 10;

        return Transform.translate(
          offset: Offset(offset, 0),
          child: child,
        );
      },
      child: Card(
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
                widget.quiz.question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              ...widget.quiz.options.map(
                    (option) => Padding(
                  padding:
                  const EdgeInsets.only(bottom: 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onAnswerSelected(option);
                      },
                      child: Text(option),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}