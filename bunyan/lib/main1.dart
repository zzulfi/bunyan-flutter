import 'package:bunyan/screens/leaderboard_page.dart';
import 'package:bunyan/screens/search_page.dart';
import 'package:bunyan/screens/fatwa_help_page.dart';
import 'package:bunyan/screens/phone_verification_page.dart';
import 'package:bunyan/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = AppState(this);
  }

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _appState,
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, // Prevent resizing when keyboard appears
        body: Stack(
          children: [
            // Content Pages
            Consumer<AppState>(
              builder: (context, appState, _) => PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  appState.setSelectedNavBarIndex(index);
                },
                children: const [
                  // MahalGramPage(),
                  PhoneVerificationPage(),
                  // LocationSelectionPage(),
                  SearchPage(),
                  LeaderboardPage(),
                  FatwaHelpPage(),
                ],
              ),
            ),

            // Bottom Navigation Bar Positioned at the bottom
            Positioned(
              bottom: 0, // Fixing it at the bottom of the screen
              left: 15.0,
              right: 15.0,
              child: Consumer<AppState>(
                builder: (context, appState, _) => CustomBottomNavigationBar(
                  onTap: (index) {
                    _pageController.jumpToPage(index);
                    appState.setSelectedNavBarIndex(index);
                  },
                  currentIndex: appState.selectedNavBarIndex,
                  borderRadius: 15, // Customize curvature
                  backgroundColor:
                      Colors.white.withOpacity(0.85), // Semi-transparent
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  // NavBar and ButtonRow State
  int _selectedNavBarIndex = 0;
  int _selectedButtonIndex = 0;

  // Post State
  final Set<int> _likedPosts = {};
  final Map<int, bool> _postLoadingState = {};

  // Search Loading State
  bool _isSearchLoading = true;

  // Expansion and Animation State
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  // Constructor to initialize AnimationController
  AppState(TickerProvider vsync) {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: vsync,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  // Dispose method for AnimationController
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // NavBar and ButtonRow Getters and Methods
  int get selectedNavBarIndex => _selectedNavBarIndex;
  int get selectedButtonIndex => _selectedButtonIndex;

  void setSelectedNavBarIndex(int index) {
    _selectedNavBarIndex = index;
    notifyListeners();
  }

  void setSelectedButtonIndex(int index) {
    _selectedButtonIndex = index;
    notifyListeners();
  }

  // Post Like and Loading Methods
  Set<int> get likedPosts => _likedPosts;
  bool isPostLoading(int postId) => _postLoadingState[postId] ?? true;

  Map<int, bool> get postLoadingState => _postLoadingState;

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

  // Search Loading Methods
  bool get isSearchLoading => _isSearchLoading;

  void setSearchLoading(bool isLoading) {
    _isSearchLoading = isLoading;
    notifyListeners();
  }

  void simulateSearchLoading() {
    setSearchLoading(true);
    Future.delayed(const Duration(seconds: 3), () {
      setSearchLoading(false);
    });
  }

  // Expansion and Animation Methods
  bool get isExpanded => _isExpanded;

  Animation<double> get rotationAnimation => _rotationAnimation;

  void toggleExpansion() {
    _isExpanded = !_isExpanded;
    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    notifyListeners();
  }

  // Filter Dropdown State
  String _selectedFilter = 'All';

  String get selectedFilter => _selectedFilter;

  void updateSelectedFilter(String newFilter) {
    _selectedFilter = newFilter;
    notifyListeners();
  }
}
