import 'package:flutter/material.dart';

class UserScoreWidget extends StatelessWidget {
  const UserScoreWidget({
    super.key,
    required this.correctAnswer,
    required this.wrongAnswer,
  });

  final int correctAnswer;
  final int wrongAnswer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserScoreItem(
          score: correctAnswer + wrongAnswer,
          title: 'Total',
        ),
        const SizedBox(width: 10),
        UserScoreItem(
          score: correctAnswer,
          title: 'Success',
        ),
        const SizedBox(width: 10),
        UserScoreItem(
          score: wrongAnswer,
          title: 'Failed',
        ),
      ],
    );
  }
}

class UserScoreItem extends StatelessWidget {
  const UserScoreItem({
    super.key,
    required this.score,
    required this.title,
  });

  final int score;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$score',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
