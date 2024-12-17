import 'package:bunyan/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryButtons extends StatelessWidget {
  const CategoryButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Row(
          children: [
            Container(
              // margin: const EdgeInsets.only(left: 7),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(12, 175, 96, 0.07),
                borderRadius: BorderRadius.circular(55),
              ),
              child: const Text(
                'All',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Satoshi',
                  color: Color(0xFF323232),
                ),
              ),
            ),
            const SizedBox(width: 7),
            Container(
                margin: const EdgeInsets.only(left: 7),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(12, 175, 96, 0.07),
                  borderRadius: BorderRadius.circular(55),
                ),
                child: const Row(
                  children: [
                    Text(
                      'District',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Satoshi',
                        color: Color(0xFF323232),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down,
                        size: 12, color: Color(0xFF323232)),
                  ],
                )),
            const SizedBox(width: 7),
            Container(
              margin: const EdgeInsets.only(left: 7),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(12, 175, 96, 0.07),
                borderRadius: BorderRadius.circular(55),
              ),
              child: const Text(
                'Village',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Satoshi',
                  color: Color(0xFF323232),
                ),
              ),
            ),
            const SizedBox(width: 7),
            Container(
              margin: const EdgeInsets.only(left: 7),
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(12, 175, 96, 0.07),
                borderRadius: BorderRadius.circular(55),
              ),
              child: const Text(
                'Zone',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Satoshi',
                  color: Color(0xFF323232),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
