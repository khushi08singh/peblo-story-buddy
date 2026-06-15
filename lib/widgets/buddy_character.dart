import 'package:flutter/material.dart';

class BuddyCharacter extends StatelessWidget {
  final bool isHappy;

  const BuddyCharacter({
    super.key,
    this.isHappy = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Text(
        isHappy ? "🤖🎉" : "🤖",
        key: ValueKey(isHappy),
        style: const TextStyle(
          fontSize: 100,
        ),
      ),
    );
  }
}