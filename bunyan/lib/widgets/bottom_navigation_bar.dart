import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final ValueChanged<int> onTap;
  final int currentIndex;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double borderRadius;
  final Color backgroundColor;

  const CustomBottomNavigationBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
    this.marginTop = 0,
    this.marginBottom = 15.0,
    this.marginLeft = 15.0,
    this.marginRight = 15.0,
    this.borderRadius = 25.0,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.groups, 'label': 'MahalGram'},
      {'icon': Icons.search, 'label': 'Search'},
      {'icon': Icons.leaderboard, 'label': 'Leaderboard'},
      {'icon': Icons.live_help, 'label': 'Fatwa Help'},
    ];

    return Container(
      margin: EdgeInsets.only(
        bottom: marginBottom,
        left: marginLeft,
        right: marginRight,
        top: marginTop,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            // spreadRadius: .5,
            blurRadius: 3,
            offset: const Offset(1, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = currentIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                // height: 40, 
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isSelected
                      ? const Color(
                          0x110CAF60) // Light green background for selected
                      : Colors.transparent,
                ),
                // padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      // transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                      child: Icon(item['icon'] as IconData,
                          key: ValueKey(isSelected),
                          color: isSelected
                              ? const Color(0xFF0CAF60)
                              : const Color(0xFFA7A7A7),
                          size: 24),
                    ),
                    // const SizedBox(height: 5),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected
                            ? const Color(0xFF0CAF60)
                            : const Color(0xFFA7A7A7),
                      ),
                      child: Text(item['label'] as String),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
