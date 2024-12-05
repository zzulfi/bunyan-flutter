import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/post_card.dart';
import '../widgets/event_card.dart';
import '../main.dart';
import '../widgets/post_category_button.dart';

// Create a placeholder JobCard widget
class JobCard extends StatelessWidget {
  final int jobId;

  const JobCard({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Job Title $jobId',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text('Description for job $jobId goes here.'),
          ],
        ),
      ),
    );
  }
}

class MahalGramPage extends StatelessWidget {
  const MahalGramPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF5F5F5),
          child: Center(
            child: Consumer<AppState>(
              builder: (context, appState, child) {
                return Column(
                  children: <Widget>[
                    const SizedBox(height: 100),
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: [
                            Color(0xFFB2B79C),
                            Color(0xFF7B9374),
                            Color(0xFFE2F2CE),
                          ],
                          stops: [0.0, 0.42, 0.95],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: const Text(
                        '#MahalGram',
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Satoshi',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const PostCategoryButton(),
                    const SizedBox(height: 4),

                    // AnimatedSwitcher to apply transition when changing content
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: _buildContent(appState.selectedButtonIndex),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // Method to return the content based on the selected button
  Widget _buildContent(int selectedButtonIndex) {
    switch (selectedButtonIndex) {
      case 1:
        return Column(
          key: ValueKey<int>(1),  // Key to trigger transition when the content changes
          children: const [
            EventCard(eventId: 1),
            EventCard(eventId: 2),
            EventCard(eventId: 3),
          ],
        );
      case 2:
        return Column(
          key: ValueKey<int>(2),
          children: const [
            JobCard(jobId: 1),
            JobCard(jobId: 2),
            JobCard(jobId: 3),
          ],
        );
      case 0:
      default:
        return Column(
          key: ValueKey<int>(0),
          children: const [
            PostCard(postId: 1),
            EventCard(eventId: 2),
            EventCard(eventId: 1),
            PostCard(postId: 2),
            PostCard(postId: 3),
          ],
        );
    }
  }
}
