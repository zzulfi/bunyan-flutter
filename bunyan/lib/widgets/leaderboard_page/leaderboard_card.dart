import 'package:bunyan/utils/color_utils.dart';
import 'package:flutter/material.dart';

class LeaderboardCard extends StatelessWidget {
  final String rank;
  final String title;
  final String imageUrl;
  final String bgImage;
  final String footerBgColor;
  final int points;
  final int activities;
  final int tasks;

  const LeaderboardCard({
    super.key,
    required this.rank,
    required this.title,
    required this.imageUrl,
    required this.bgImage,
    required this.footerBgColor,
    required this.points,
    required this.activities,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.only(top: 20, left: 28, right: 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 0.5),
        image: DecorationImage(
          image: AssetImage(bgImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(rank: rank),
          const SizedBox(height: 10),
          _buildAvatarSection(
            imageUrl: imageUrl,
            title: title,
            points: points,
            trophyImage: 'assets/images/trophy.png',
          ),
          const SizedBox(height: 10),
          _buildFooter(activities: activities, tasks: tasks, points: points),
        ],
      ),
    );
  }

  /// Header Section
  Widget _buildHeader({required String rank}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rank,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(width: 6),
        const Text(
          'LEADING',
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  /// Avatar Section
  Widget _buildAvatarSection({
    required String imageUrl,
    required String title,
    required int points,
    required String trophyImage,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE5E5E5), width: 6),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 13),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF552003),
                  fontFamily: "Satoshi",
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 5),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$points',
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color(0xFF552003),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Satoshi",
                      ),
                    ),
                    const TextSpan(
                      text: 'pts',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8C7E38),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Satoshi",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Image.asset(trophyImage, 
          height: 75,
          width: 75,
          ),
        ),
      ],
    );
  }

  /// Footer Section
  Widget _buildFooter({
    required int activities,
    required int tasks,
    required int points,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 23, right: 23, bottom: 15),
      decoration: BoxDecoration(
        color: parseRgbaToColor(footerBgColor),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        border: Border.all(
          color: const Color.fromRGBO(240, 240, 240, 0.29),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          _buildFooterColumn(label: 'ACTIVITIES', value: activities.toString()),
          const SizedBox(width: 20),
          _buildFooterColumn(label: 'TASKS', value: tasks.toString()),
          const SizedBox(width: 20),
          _buildFooterColumn(
            label: 'POINTS',
            value: '$points',
          ),
        ],
      ),
    );
  }

  /// Footer Column
  Widget _buildFooterColumn({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3.5),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(38, 42, 10, 0.38),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              TextSpan(
                text: label == 'POINTS' ? ' pts' : '',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
