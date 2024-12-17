import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:bunyan/utils/color_utils.dart';

class LeaderboardCardSkeleton extends StatelessWidget {
  final String bgImage;
  final String footerBgColor;

  const LeaderboardCardSkeleton({
    super.key,
    required this.bgImage,
    required this.footerBgColor,
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
          _buildHeaderSkeleton(),
          const SizedBox(height: 10),
          _buildAvatarSectionSkeleton(),
          const SizedBox(height: 10),
          _buildFooterSkeleton(),
        ],
      ),
    );
  }

  /// Header Skeleton
  Widget _buildHeaderSkeleton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShimmerPlaceholder(width: 30, height: 10),
        const SizedBox(width: 6),
        _buildShimmerPlaceholder(width: 50, height: 10),
      ],
    );
  }

  /// Avatar Section Skeleton
  Widget _buildAvatarSectionSkeleton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShimmerCircle(size: 70),
        const SizedBox(width: 13),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShimmerPlaceholder(width: 120, height: 20),
              const SizedBox(height: 5),
              _buildShimmerPlaceholder(width: 80, height: 15),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Image.asset(
              'assets/images/trophy.png'), // Keep the actual image for the trophy.
        ),
      ],
    );
  }

  /// Footer Skeleton
  Widget _buildFooterSkeleton() {
    // Parse RGBA string into Color directly
   

    return Container(
      padding: const EdgeInsets.only(top: 12, left: 23, right: 23, bottom: 15),
      decoration: BoxDecoration(
        // color: footerColor,
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
          _buildFooterColumnSkeleton(),
          const SizedBox(width: 20),
          _buildFooterColumnSkeleton(),
          const SizedBox(width: 20),
          _buildFooterColumnSkeleton(),
        ],
      ),
    );
  }

  /// Footer Column Skeleton
  Widget _buildFooterColumnSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShimmerPlaceholder(width: 50, height: 15),
        const SizedBox(height: 4),
        _buildShimmerPlaceholder(width: 40, height: 20),
      ],
    );
  }

  /// Shimmer Placeholder
  Widget _buildShimmerPlaceholder(
      {required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  /// Shimmer Circle Placeholder
  Widget _buildShimmerCircle({required double size}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
