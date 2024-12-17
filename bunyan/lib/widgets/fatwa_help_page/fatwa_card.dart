import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bunyan/main.dart';


class FatwaCard extends StatelessWidget {
  final String bgImage;
  final String question;
  final String answer;
  final String date;

  const FatwaCard({
    required this.bgImage,
    required this.question,
    required this.answer,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context); // Access AppState here

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(17),
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderRow(appState),
          const SizedBox(height: 10),
          _buildTitle(),
          _buildExpandedContent(appState),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(bgImage),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey, width: 0.5),
    );
  }

  Widget _buildHeaderRow(AppState appState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          date, // Display the provided date
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            fontFamily: 'Satoshi',
            color: Color(0xFF9C9A9A),
          ),
        ),
        RotationTransition(
          turns: appState.rotationAnimation,
          child: const Icon(
            Icons.expand_more,
            color: Color(0xFF9C9A9A),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      question, // Use the provided question
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontFamily: 'Satoshi',
        color: Colors.black,
        height: 1.2,
      ),
    );
  }

  Widget _buildExpandedContent(AppState appState) {
    return AnimatedCrossFade(
      sizeCurve: Curves.easeOutQuint,
      duration: const Duration(milliseconds: 500),
      firstChild: const SizedBox.shrink(),
      secondChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Answer',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              fontFamily: 'Satoshi',
              color: Color(0xFF9C9A9A),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            answer, // Use the provided answer
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Satoshi',
              color: Colors.black,
            ),
          ),
        ],
      ),
      crossFadeState: appState.isExpanded
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
    );
  }
}
