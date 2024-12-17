import 'package:bunyan/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostCategoryButton extends StatelessWidget {
  const PostCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: SizedBox(
            child: Stack(
              children: [
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PostCategoryButtonItem(
                        label: 'All Posts',
                        index: 0,
                        isActive: appState.selectedButtonIndex == 0),
                    const SizedBox(width: 5),
                    PostCategoryButtonItem(
                        label: 'Events',
                        index: 1,
                        isActive: appState.selectedButtonIndex == 1),
                    const SizedBox(width: 5),
                    PostCategoryButtonItem(
                        label: 'Jobs',
                        index: 2,
                        isActive: appState.selectedButtonIndex == 2),
                  ],
                ),
                // Sliding underline
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                  left: appState.selectedButtonIndex * 85.0 + (85.0 - 60) / 2, // Center the underline
                  bottom: 0,
                  child: Container(
                    width: 60, // Width of the underline
                    height: 2,
                    color: const Color(0xFF0CAF60), // Green color
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PostCategoryButtonItem extends StatelessWidget {
  final String label;
  final int index;
  final bool isActive;

  const PostCategoryButtonItem({
    super.key,
    required this.label,
    required this.index,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return SizedBox(
      width: 80, // Set consistent width for buttons
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          appState.setSelectedButtonIndex(index);
        },
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF0CAF60) : Colors.grey,
            fontSize: 14,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
