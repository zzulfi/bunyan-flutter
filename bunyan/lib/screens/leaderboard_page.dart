import 'package:bunyan/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bunyan/widgets/leaderboard_page/leaderboard_card.dart';
import 'package:bunyan/widgets/leaderboard_page/skelton/leaderboard_card_skeleton.dart';
import 'package:bunyan/widgets/leaderboard_page/leaderboard_table.dart';
import 'package:bunyan/widgets/leaderboard_page/skelton/leaderboard_table_skelton.dart';
import 'package:bunyan/services/get_leaderboard_service.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final GetLeaderboardService leaderboardService = GetLeaderboardService();
  List<Map<String, dynamic>> leaderboardData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLeaderboard();
  }

  /// Fetch leaderboard data from the service
  Future<void> fetchLeaderboard() async {
    try {
      final data =
          await leaderboardService.getLeaderboard(limit: 10, offset: 0);
      setState(() {
        leaderboardData = data ?? [];
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching leaderboard: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    // Trigger loading simulation on first build
    if (appState.isSearchLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appState.simulateSearchLoading();
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF5F5F5),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 60),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.west,
                      size: 25,
                      color: Color.fromARGB(0, 0, 0, 0),
                    ),
                    Icon(
                      Icons.search,
                      size: 25,
                      color: Color(0xFF323232),
                    ),
                  ],
                ),
                const Text(
                  'Leaderboard',
                  style: TextStyle(
                    fontSize: 26,
                    color: Color(0xFF323232),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const SizedBox(height: 8),
                // CategoryButtons(),
                if (isLoading)
                  const Column(
                    children: [
                      LeaderboardCardSkeleton(
                        bgImage: 'assets/images/leaderboard_gold_bg.png',
                        footerBgColor: '178, 161, 64, 0.14',
                      ),
                      LeaderboardCardSkeleton(
                        bgImage: 'assets/images/leaderboard_silver_bg.png',
                        footerBgColor: '86, 86, 86, 0.14',
                      ),
                      LeaderboardCardSkeleton(
                        bgImage: 'assets/images/leaderboard_bronze_bg.png',
                        footerBgColor: '178, 131, 64, 0.14',
                      ),
                      LeaderboardTableSkeleton(),
                    ],
                  )
                else
                  Column(
                    children: [
                      ...leaderboardData.take(3).map((item) {
                        // print index
                        // print( leaderboardData.indexOf(item));
                        final index = leaderboardData.indexOf(item) + 1;
                        return LeaderboardCard(
                          rank: "#$index",
                          title: "${item['name']} Mahallu",
                          imageUrl: item['imageUrl'] ??
                              'https://via.placeholder.com/70',
                          bgImage:
                              'assets/images/leaderboard_${index == 1 ? 'gold' : index == 2 ? 'silver' : 'bronze'}_bg.png',
                          footerBgColor: index == 1
                              ? '178, 161, 64, 0.14'
                              : index == 2
                                  ? '86, 86, 86, 0.14'
                                  : '178, 131, 64, 0.14',
                          points: item['totalPoints'],
                          activities: item['counts']['otherPrograms'],
                          tasks: item['counts']['taskParticipants'],
                        );
                      }),
                      LeaderboardTable(
                        rows: leaderboardData.skip(3).map((item) {
                          final index = leaderboardData.indexOf(item) + 1;
                          return {
                            'rank': "#$index",
                            'name': '${item['name']} Mahallu',
                            'points': item['totalPoints'],
                            'imageUrl': item['imageUrl'] ??
                                'https://via.placeholder.com/23',
                          };
                        }).toList(),
                      ),
                    ],
                  ),
                const SizedBox(
                    height:
                        65), // Bottom padding to remove overlap with BottomNavigationBar
              ],
            ),
          ),
        ),
      ),
    );
  }
}
