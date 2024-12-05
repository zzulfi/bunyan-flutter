import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart'; // Adjust the import as per your AppState location.

class CustomBottomNavigationBar extends StatelessWidget {
  final ValueChanged<int> onTap;
  // const CustomBottomNavigationBar({Key? key}) : super(key: key);

  const CustomBottomNavigationBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Container(
          height: 65,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 1.5,
                blurRadius: 3,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: appState.selectedNavBarIndex,
            onTap: (index) {
              appState.setSelectedNavBarIndex(index);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.groups),
                label: 'MahalGram',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard),
                label: 'Leaderboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.live_help),
                label: 'Fatwa Help',
              ),
            ],
            selectedItemColor: const Color(0xFF0CAF60),
            unselectedItemColor: const Color(0xFFA7A7A7),
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFFF5F5F5),
            selectedLabelStyle: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      },
    );
  }
}
