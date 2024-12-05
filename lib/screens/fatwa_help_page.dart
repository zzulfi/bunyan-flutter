import 'package:flutter/material.dart';

class FatwaHelpPage extends StatelessWidget {
  const FatwaHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Fatwa Help Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
