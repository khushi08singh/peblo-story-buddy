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
      child: SizedBox(
        key: ValueKey(isHappy),
        height: 240,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/robot.png",
              height: 230,
            ),

            if (isHappy)
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "🎉",
                  style: TextStyle(fontSize: 70),
                ),
              ),
          ],
        ),
      ),
    );
  }
}