import 'package:flutter/material.dart';

class StoryCard extends StatelessWidget {
  final String storyText;

  const StoryCard({
    super.key,
    required this.storyText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          storyText,
          style: const TextStyle(
            fontSize: 18,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}