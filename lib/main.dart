import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/mahalgram_page.dart';
import 'screens/search_page.dart';
import 'screens/leaderboard_page.dart';
import 'screens/fatwa_help_page.dart';
import 'widgets/bottom_navigation_bar.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(), // Ensure AppState is provided
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5)),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          appState.setSelectedNavBarIndex(index);
        },
        children: const [
          MahalGramPage(),
          SearchPage(),
          LeaderboardPage(),
          FatwaHelpPage(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  int _selectedNavBarIndex = 0; // Default selected index (MahalGram)
  int _selectedButtonIndex = 0; // Default index for ButtonRow (All Posts)
  final Set<int> _likedPosts = {}; // Track liked posts
  final Map<int, bool> _postLoadingState =
      {}; // Track loading state for each post

  int get selectedNavBarIndex => _selectedNavBarIndex;
  int get selectedButtonIndex => _selectedButtonIndex;
  Set<int> get likedPosts => _likedPosts;
  bool isPostLoading(int postId) => _postLoadingState[postId] ?? true;

  Map<int, bool> get postLoadingState => _postLoadingState;

  void setSelectedNavBarIndex(int index) {
    _selectedNavBarIndex = index;
    notifyListeners();
  }

  void setSelectedButtonIndex(int index) {
    _selectedButtonIndex = index;
    notifyListeners();
  }

  void toggleLike(int postId) {
    if (_likedPosts.contains(postId)) {
      _likedPosts.remove(postId);
    } else {
      _likedPosts.add(postId);
    }
    notifyListeners();
  }

  void setPostLoading(int postId, bool isLoading) {
    _postLoadingState[postId] = isLoading;
    notifyListeners();
  }

  void simulatePostLoading(int postId) {
    setPostLoading(postId, true);
    Future.delayed(const Duration(seconds: 3), () {
      setPostLoading(postId, false);
    });
  }
}
