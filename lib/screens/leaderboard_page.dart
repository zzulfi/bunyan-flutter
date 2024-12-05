import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Leaderboard Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
