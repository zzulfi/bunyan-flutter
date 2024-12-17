import 'package:bunyan/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AskBox extends StatelessWidget {
  const AskBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFFC8C8C8),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Ask or search for anything...',
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.only(top: 7),
            ),
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Satoshi',
            ),
          ),
        );
      },
    );
  }
}
