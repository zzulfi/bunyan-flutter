import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class PostCategoryButton extends StatelessWidget {
  const PostCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
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

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor:
            isActive ? const Color(0xFF0CAF60) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        side: BorderSide(
          color: isActive ? const Color(0xFF0CAF60) : Colors.grey,
          width: 0.5,
        ),
      ),
      onPressed: () {
        appState.setSelectedButtonIndex(index);
      },
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey,
          fontSize: 12,
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
