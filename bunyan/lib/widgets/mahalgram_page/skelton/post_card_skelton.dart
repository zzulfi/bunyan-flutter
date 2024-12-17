import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostCardSkeleton extends StatelessWidget {
  const PostCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
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
          // Header Skeleton
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildShimmerProfilePicture(),
              const SizedBox(width: 6),
              _buildShimmerProfileDetails(),
              const Spacer(),
              const Icon(Icons.more_vert, size: 20, color: Colors.black),
            ],
          ),
          const Divider(color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 5),
          // Body Skeleton
          _buildShimmerBody(),
          const SizedBox(height: 10),
          // Sliding Images Skeleton
          _buildShimmerPostImage(),
          const SizedBox(height: 10),
          // Footer Skeleton
          Row(
            children: [
              _buildShimmerLikeButton(),
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

  Widget _buildShimmerLikeButton() {
    return Row(
      children: [
        const Icon(
          Icons.favorite_border,
          size: 22,
          color: Color(0xFF0CAF60),
        ),
        const SizedBox(width: 5),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 10,
            width: 50,
            color: Colors.grey.shade300,
          ),
        )
      ],
    );
  }
}
