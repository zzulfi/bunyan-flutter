import 'package:bunyan/main.dart';
import 'package:bunyan/widgets/mahalgram_page/event_card.dart';
import 'package:bunyan/widgets/mahalgram_page/post_card.dart';
import 'package:bunyan/widgets/mahalgram_page/job_card/job_card.dart';
import 'package:bunyan/widgets/mahalgram_page/post_category_button.dart';
import 'package:bunyan/widgets/profile_page/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                    const ProfileCard(
                      title: 'Pookkolathur Mahallu',
                      imageUrl: 'https://via.placeholder.com/120',
                      rank: '#238',
                      location:
                          'San Francisco, CA San Francisco, CA San Francisco, CA',
                      points: '2958',
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PostCategoryButton(),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // AnimatedSwitcher(
                    //   duration: const Duration(milliseconds: 300),
                    //   transitionBuilder:
                    //       (Widget child, Animation<double> animation) {
                    //     return FadeTransition(opacity: animation, child: child);
                    //   },
                    //   child: _buildContent(appState.selectedButtonIndex),
                    // ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildContent(int selectedButtonIndex) {
  //   switch (selectedButtonIndex) {
  //     case 1:
  //       return const Column(
  //         key: ValueKey<int>(1),
  //         children: [
  //           EventCard(eventId: 1),
  //           EventCard(eventId: 2),
  //           EventCard(eventId: 3),
  //         ],
  //       );
  //     case 2:
  //       return const Column(
  //         key: ValueKey<int>(2),
  //         children: [
  //           JobCard(jobId: 1),
  //           JobCard(jobId: 2),
  //           JobCard(jobId: 3),
  //         ],
  //       );
  //     case 0:
  //     default:
  //       return const Column(
  //         key: ValueKey<int>(0),
  //         children: [
  //           PostCard(postId: 1),
  //           EventCard(eventId: 2),
  //           EventCard(eventId: 1),
  //           PostCard(postId: 2),
  //           PostCard(postId: 3),
  //         ],
  //       );
  //   }
  // }
}
