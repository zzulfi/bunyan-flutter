import 'package:bunyan/main.dart';
import 'package:bunyan/widgets/search_page/profile_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ProfileDetails extends StatelessWidget {
  final int postId;
  final String name;
  final String place;

  const ProfileDetails({
    super.key,
    required this.postId,
    required this.name,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfilePicture(),
          const SizedBox(width: 10),
          _buildProfileDetails(),
          const Spacer(),
          // const Icon(Icons.close, size: 18, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Container(
      width: 45,
      height: 45,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage('https://via.placeholder.com/45'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "Satoshi",
          ),
        ),
        Text(
          place,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
            fontFamily: "Satoshi",
          ),
        ),
      ],
    );
  }
}
