import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Skeleton Table Contents
class LeaderboardTableSkeleton extends StatelessWidget {
  final int rowCount;

  const LeaderboardTableSkeleton({super.key, this.rowCount = 5});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(rowCount, (index) => _buildSkeletonRow()),
    );
  }

  /// Skeleton Row
  Widget _buildSkeletonRow() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        // margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(200, 200, 200, 1),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildShimmerBox(width: 20, height: 12), // Rank shimmer
            const SizedBox(width: 35),
            _buildShimmerCircle(size: 23), // Profile picture shimmer
            const SizedBox(width: 5),
            Expanded(
              flex: 5,
              child: _buildShimmerBox(width: double.infinity, height: 12), // Name shimmer
            ),
            const Spacer(),
            _buildShimmerBox(width: 40, height: 12), // Points shimmer
          ],
        ),
      ),
    );
  }

  /// Shimmer Circle
  Widget _buildShimmerCircle({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  /// Shimmer Box
  Widget _buildShimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
