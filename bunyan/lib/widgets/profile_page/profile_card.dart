import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String rank;
  final String location;
  final String points;

  const ProfileCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.rank,
    required this.location,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackgroundContainer(),
        _buildGradientOverlay(),
        _buildProfileContent(),
      ],
    );
  }

  // Background Container
  Widget _buildBackgroundContainer() {
    return Container(
      key: const ValueKey('profile-header'),
      width: double.infinity,
      height: 390,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        border: Border.all(
          color: const Color(0xFF9C9A9A),
          width: 0.5,
        ),
      ),
    );
  }

  // Gradient Overlay
  Widget _buildGradientOverlay() {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/profile-gradient.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Profile Content
  Widget _buildProfileContent() {
    return Positioned(
      top: 60,
      left: 30,
      right: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileRow(),
          const SizedBox(height: 10),
          _buildTitleAndRankRow(),
          const SizedBox(height: 10),
          _buildLocationRow(),
          const SizedBox(height: 10),
          _buildPointsRow(),
        ],
      ),
    );
  }

  // Profile Row (Image + Badges)
  Widget _buildProfileRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfilePicture(),
        _buildBadges(),
      ],
    );
  }

  // Profile Picture
  Widget _buildProfilePicture() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFE5E5E5),
          width: 7,
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Badges
  Widget _buildBadges() {
    return Container(
      key: const ValueKey('badges'),
      margin: const EdgeInsets.only(left: 7, top: 7),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(55),
      ),
      child: Row(
        children: [
          _buildBadgeStack(),
          const SizedBox(width: 30),
          const Text(
            '+2',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Satoshi',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Badge Stack
  Widget _buildBadgeStack() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 24,
          child: _buildBadge(Colors.black),
        ),
        Positioned(
          left: 12,
          child: _buildBadge(Colors.green),
        ),
        _buildBadge(Colors.red),
      ],
    );
  }

  // Individual Badge
  Widget _buildBadge(Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(2, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: Icon(
        Icons.local_police,
        size: 15,
        color: color,
      ),
    );
  }

  Widget _buildRankingText() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'RANKING',
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Satoshi',
            color: Color.fromARGB(86, 50, 50, 50),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Title and Rank Row
  Widget _buildTitleAndRankRow() {
    return Column(
      children: [
        _buildRankingText(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Satoshi',
                  height: 1.2,
                ),
              ),
            ),
            Text(
              rank,
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: 'Satoshi',
                color: Color(0xFF0CAF60),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Location Row
  Widget _buildLocationRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 236, 236, 236),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.location_on_outlined,
              size: 15,
              color: Color(0xFF9C9A9A),
            ),
          ),
        ),
        const SizedBox(width: 7),
        Flexible(
          flex: 2,
          child: Text(
            location,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF9C9A9A),
              fontFamily: 'Satoshi',
            ),
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ],
    );
  }

  // Points Row
  Widget _buildPointsRow() {
    return Row(
      children: [
        _buildPoints(points, const Color(0xFFCBF0E4)),
        const SizedBox(width: 15),
        _buildPoints('1234', const Color(0xFFDFE49E)), // Example second points
      ],
    );
  }

  // Individual Points Container
  Widget _buildPoints(String points, Color backgroundColor) {
    return Row(
      children: [
        Text(
          points,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Satoshi',
            color: Colors.black,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 7),
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(55),
          ),
          child: const Text(
            'POINTS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              fontFamily: 'Satoshi',
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
