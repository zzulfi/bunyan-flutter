import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../main.dart';

class PostCard extends StatelessWidget {
  final int postId;

  const PostCard({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isLiked = appState.likedPosts.contains(postId);
    final isLoading = appState.isPostLoading(postId);

    // Simulate loading state on initialization
    if (!appState.postLoadingState.containsKey(postId)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appState.simulatePostLoading(postId);
      });
    }
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   appState.simulatePostLoading(postId);
    // });

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isLoading
                  ? _buildShimmerProfilePicture()
                  : _buildProfilePicture(),
              const SizedBox(width: 6),
              isLoading
                  ? _buildShimmerProfileDetails()
                  : _buildProfileDetails(),
              const Spacer(),
              isLoading
                  ? _buildShimmerMoreOptions()
                  : const Icon(Icons.more_vert, size: 20, color: Colors.black),
            ],
          ),
          const Divider(color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 5),
          // Body
          isLoading ? _buildShimmerBody() : _buildPostBody(),
          const SizedBox(height: 10),
          // Image
          isLoading ? _buildShimmerPostImage() : _buildPostImage(),
          const SizedBox(height: 10),
          // Footer
          Row(
            children: [
              _buildLikeButton(context, isLiked, postId, isLoading),
              const Spacer(),
              const Icon(Icons.share_outlined, size: 18, color: Colors.black),
              const SizedBox(width: 5),
              const Text(
                "Share",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Satoshi",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerProfilePicture() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade300,
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Container(
      width: 35,
      height: 35,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
              'https://via.placeholder.com/35'), // Replace with actual profile image URL
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildShimmerProfileDetails() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 12,
            width: 100,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 5),
          Container(
            height: 10,
            width: 50,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Profile Name",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "Satoshi",
          ),
        ),
        Text(
          "2h ago",
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontFamily: "Satoshi",
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerMoreOptions() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 20,
        width: 20,
        color: Colors.grey.shade300,
      ),
    );
  }

  Widget _buildShimmerBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 20,
            width: 150,
            color: Colors.grey.shade300,
          ),
        ),
        const SizedBox(height: 5),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 12,
            width: 200,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _buildPostBody() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Post Title",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "Satoshi",
          ),
        ),
        SizedBox(height: 5),
        Text(
          "This is a sample description of the post. It gives an overview of what this post is about.",
          style: TextStyle(
            fontSize: 11.2,
            color: Colors.black54,
            fontFamily: "Satoshi",
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerPostImage() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Colors.grey.shade300,
        ),
      ),
    );
  }

  Widget _buildPostImage() {
    return Container(
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        image: const DecorationImage(
          image: NetworkImage('https://via.placeholder.com/400x210'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLikeButton(
      BuildContext context, bool isLiked, int postId, bool isLoading) {
    final appState = Provider.of<AppState>(context);
    return GestureDetector(
      onTap: () {
        appState.toggleLike(postId);
      },
      child: Row(
        children: [
          AnimatedScale(
            scale: isLiked ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            child: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              size: 22,
              color: const Color(0xFF0CAF60),
            ),
          ),
          const SizedBox(width: 5),
          isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 10,
                    width: 50,
                    color: Colors.grey.shade300,
                  ),
                )
              : Text(
                  isLiked ? "1.1k likes" : "1k likes",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Satoshi",
                  ),
                ),
        ],
      ),
    );
  }
}
