import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bunyan/main.dart';
import 'package:bunyan/widgets/mahalgram_page/event_card.dart';
import 'package:bunyan/widgets/mahalgram_page/job_card/job_card.dart';
import 'package:bunyan/widgets/mahalgram_page/job_card/job_card_small.dart';
import 'package:bunyan/widgets/mahalgram_page/post_card.dart';
import 'package:bunyan/widgets/mahalgram_page/post_category_button.dart';

import 'package:bunyan/services/get_shuffled_content_service.dart';

class MahalGramPage extends StatefulWidget {
  const MahalGramPage({super.key});

  @override
  State<MahalGramPage> createState() => _MahalGramPageState();
}

class _MahalGramPageState extends State<MahalGramPage> {
  late ScrollController _scrollController;
  final GetShuffledContentService _service = GetShuffledContentService();
  Map<String, dynamic>? _shuffledContent;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fetchContent();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchContent() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await _service.getShuffledContent(
        eventLimit: 5,
        jobLimit: 5,
        postLimit: 5,
      );

      setState(() {
        _shuffledContent = data;
      });
    } catch (e) {
      print('Error fetching content: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshContent() async {
    await _fetchContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        edgeOffset: 100,
        onRefresh: _refreshContent,
        color: Colors.green,
        backgroundColor: Colors.white,
        child: Consumer<AppState>(
          builder: (context, appState, child) {
            if (appState.selectedButtonIndex == 2) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_scrollController.hasClients) {
                  _scrollController.jumpTo(0);
                }
              });
            }

            return _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    controller: _scrollController,
                    child: Container(
                      color: const Color(0xFFF5F5F5),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 40),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // add this image here logo-text-only.png
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/logo.png',
                                        width: 50,
                                      ),
                                      SizedBox(width: 10),
                                      Image.asset(
                                        'assets/images/logo-text-only.png',
                                        width: 150,
                                      ),
                                    ],
                                  )
                                  // Image.asset(
                                  //   'assets/images/logo.png',
                                  //   width: 50,
                                  // ),
                                  // Image.asset(
                                  //   'assets/images/logo-text-only.png',
                                  //   width: 150,
                                  // ),
                                  // const Text(
                                  //   'Bunyan',
                                  //   style: TextStyle(
                                  //     fontSize: 25,
                                  //     color: Color.fromARGB(255, 66, 66, 66),
                                  //     fontWeight: FontWeight.bold,
                                  //     fontFamily: 'Satoshi',
                                  //   ),
                                  // ),
                                  // const Text(
                                  //   'MahalGram',
                                  //   style: TextStyle(
                                  //     fontSize: 35,
                                  //     color: Colors.black,
                                  //     fontWeight: FontWeight.bold,
                                  //     fontFamily: 'Satoshi',
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const PostCategoryButton(),
                            const SizedBox(height: 4),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 100),
                              transitionBuilder: (child, animation) =>
                                  FadeTransition(
                                      opacity: animation, child: child),
                              child:
                                  _buildContent(appState.selectedButtonIndex),
                            ),
                            const SizedBox(height: 65),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget _buildContent(int selectedButtonIndex) {
    if (_shuffledContent == null) {
      return const Center(child: Text('No data available'));
    }

    switch (selectedButtonIndex) {
      case 1:
        return Column(
          key: const ValueKey<int>(1),
          children: (_shuffledContent!['events'] as List<dynamic>)
              .map((event) => EventCard(
                    eventId: event['id'],
                    title: event['title'],
                    description: event['description'],
                    startingAt: event['startingDate'],
                    location: event['location'],
                    postedAt: event['updatedAt'],
                    eventImageURL: event['posterURL'],
                  ))
              .toList(),
        );
      case 2:
        return Column(
          key: const ValueKey<int>(2),
          children: (_shuffledContent!['jobs'] as List<dynamic>)
              .map((job) => JobCard(
                    jobId: job['id'],
                    title: job['title'],
                    location: job['location'],
                    description: job['description'],
                    skills: job['skills'],
                    postedAt: job['postedDate'],
                  ))
              .toList(),
        );
      case 0:
      default:
        return Column(
          key: const ValueKey<int>(0),
          children: [
            ...(_shuffledContent!['posts'] as List<dynamic>)
                .map((post) => PostCard(
                      postId: post['id'],
                      title: post['title'],
                      description: post['description'],
                      postedAt: post['updatedAt'],
                      postImageURL: post['fileURL'],
                      author: post['mahallu']['name'],
                      likes: post['likes'],
                    ))
                .toList(),
            // ...(_shuffledContent!['jobs'] as List<dynamic>)
            //     .map((job) => JobCardSmall(
            //       jobs: [job],
            //         ))
            //     .toList(),
            JobCardSmall(jobs: _shuffledContent!['jobs']),
            ...(_shuffledContent!['events'] as List<dynamic>)
                .map((event) => EventCard(
                      eventId: event['id'],
                      title: event['title'],
                      description: event['description'],
                      startingAt: event['startingDate'],
                      location: event['location'],
                      postedAt: event['updatedAt'],
                      eventImageURL: event['posterURL'],
                    ))
                .toList(),
          ],
        );
    }
  }
}
