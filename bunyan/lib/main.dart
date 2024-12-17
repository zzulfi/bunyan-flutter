import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bunyan/screens/phone_verification_page.dart';
import 'package:bunyan/screens/location_selection_page.dart';
import 'package:bunyan/screens/mahalgram_page.dart';
import 'package:bunyan/screens/search_page.dart';
import 'package:bunyan/screens/leaderboard_page.dart';
import 'package:bunyan/screens/fatwa_help_page.dart';
import 'package:bunyan/screens/profile_page.dart';
import 'package:bunyan/widgets/bottom_navigation_bar.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(
          vsync: null), // Replace `null` with appropriate vsync if needed
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
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      initialRoute: '/',
      routes: {
        // '/': (context) => const SplashScreen(),
        '/': (context) => const PhoneVerificationPage(),
        '/phoneVerification': (context) => const PhoneVerificationPage(),
        '/locationSelection': (context) => const LocationSelectionPage(),
        '/mainPage': (context) => const MainPage(),
        '/profile': (context) => const ProfilePage(),
      },
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
  late AppState _appState;
  late PageController _pageController; // Add PageController

  @override
  void initState() {
    super.initState();
    _appState = AppState();
    _pageController = PageController(
        initialPage:
            _appState.selectedNavBarIndex); // Initialize with the current index
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose PageController
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>.value(
      value: _appState,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // Content Pages
            Consumer<AppState>(
              builder: (context, appState, _) => PageView(
                controller: _pageController, // Use PageController
                onPageChanged: (index) {
                  appState.setSelectedNavBarIndex(
                      index); // Update AppState on page change
                },
                children: const [
                  MahalGramPage(),
                  SearchPage(),
                  LeaderboardPage(),
                  FatwaHelpPage(),
                ],
              ),
            ),
            // Bottom Navigation Bar
            Positioned(
              bottom: 0,
              left: 15.0,
              right: 15.0,
              child: Consumer<AppState>(
                builder: (context, appState, _) => CustomBottomNavigationBar(
                  onTap: (index) {
                    appState.setSelectedNavBarIndex(index); // Update AppState
                    _pageController.jumpToPage(index); // Update PageView
                  },
                  currentIndex: appState.selectedNavBarIndex,
                  borderRadius: 20,
                  backgroundColor: Colors.white.withOpacity(0.96),
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
  AppState({TickerProvider? vsync}) {
    if (vsync != null) {
      _initializeAnimation(vsync);
    }
  }

  void _initializeAnimation(TickerProvider vsync) {
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
  // bool get isSearchLoading => _isSearchLoading;

  // void setSearchLoading(bool isLoading) {
  //   _isSearchLoading = isLoading;
  //   notifyListeners();
  // }

    bool isSearchLoading = false;
  List<Map<String, dynamic>> searchResults = [];

  void setSearchLoading(bool isLoading) {
    isSearchLoading = isLoading;
    notifyListeners();
  }

  void updateSearchResults(List<Map<String, dynamic>> results) {
    searchResults = results;
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
  String _selectedFilter = 'Mahallu';

  String get selectedFilter => _selectedFilter;

  void updateSelectedFilter(String newFilter) {
    _selectedFilter = newFilter;
    notifyListeners();
  }

  Map<String, String> userDetails = {
    "phone": "",
    "district": "",
    "village": "",
    "mahall": "",
    "zone": "",
  };

  // Getter for userDetails
  Map<String, String> get getUserDetails => userDetails;

  // Setter for user details
  void setUserDetails({
    String? phone,
    String? district,
    String? village,
    String? mahall,
    String? zone,
  }) {
    if (phone != null) userDetails["phone"] = phone;
    if (district != null) userDetails["district"] = district;
    if (village != null) userDetails["village"] = village;
    if (mahall != null) userDetails["mahall"] = mahall;
    if (zone != null) userDetails["zone"] = zone;

    notifyListeners();
  }
}
