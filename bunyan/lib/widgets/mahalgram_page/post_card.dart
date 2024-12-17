import 'package:bunyan/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:bunyan/utils/datetime.dart';

class PostCard extends StatefulWidget {
  final int postId;
  final String title;
  final String description;
  final String postImageURL;
  final String author;
  final String postedAt;
  final int likes;

  const PostCard({
    super.key,
    required this.postId,
    required this.title,
    required this.description,
    required this.postImageURL,
    required this.author,
    required this.postedAt,
    required this.likes,
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late PageController _pageController;
  bool _isHidden = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isLiked = appState.likedPosts.contains(widget.postId);
    final isLoading = appState.isPostLoading(widget.postId);

    if (!appState.postLoadingState.containsKey(widget.postId)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appState.simulatePostLoading(widget.postId);
      });
    }

    if (_isHidden) {
      return _buildHiddenView(context);
    }

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
              SizedBox(
                width: 30,
                height: 35,
                child: _buildDropdownMenu(),
              ),
            ],
          ),
          const Divider(color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 5),
          // Body
          isLoading ? _buildShimmerBody() : _buildPostBody(),
          const SizedBox(height: 10),
          // Sliding images (like Instagram)
          isLoading ? _buildShimmerPostImage() : _buildPostImage(),
          const SizedBox(height: 10),
          // Footer
          Row(
            children: [
              _buildLikeButton(context, isLiked, widget.postId, isLoading),
              const Spacer(),
              _buildShareButton(context),
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
          image: NetworkImage('https://via.placeholder.com/35'),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.author,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "Satoshi",
          ),
        ),
        Text(
          formatTimestamp(widget.postedAt),
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontFamily: "Satoshi",
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownMenu() {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'hide') {
          setState(() {
            _isHidden = true;
          });
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<String>(
          value: 'hide',
          height: 30,
          child: Row(
            children: [
              Icon(Icons.visibility_off, size: 18, color: Colors.black),
              SizedBox(width: 10),
              Text("Hide"),
            ],
          ),
        ),
      ],
      icon: const Icon(Icons.more_vert, size: 20, color: Colors.black),
      color: Colors.white,
      tooltip: "More",
    );
  }

  Widget _buildHiddenView(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.only(top: 17, left: 17, right: 17),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "This post has been hidden",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontFamily: "Satoshi",
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isHidden = false;
              });
            },
            child: const Text(
              "Undo",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF0CAF60),
                fontWeight: FontWeight.bold,
                fontFamily: "Satoshi",
              ),
            ),
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

  Widget _buildPostBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "Satoshi",
            height: 1.2,
          ),
        ),
        SizedBox(height: 5),
        Text(
          widget.description,
          style: TextStyle(
            fontSize: 11.2,
            color: Colors.black54,
            fontFamily: "Inter",
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
    return Column(
      children: [
        SizedBox(
          height: 210,
          child: PageView(
            controller: _pageController,
            children: [
              _buildImageContainer(widget.postImageURL),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLikeButton(
      BuildContext context, bool isLiked, int postId, bool isLoading) {
    final appState = Provider.of<AppState>(context);
    final likes = widget.likes;
    return GestureDetector(
      onTap: () {
        appState.toggleLike(postId);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10, right: 15),
        child: Row(
          children: [
            AnimatedScale(
              scale: isLiked ? 1.2 : 1.0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 100),
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                size: 22,
                color: Color(0xFF0CAF60),
              ),
            ),
            const SizedBox(width: 6),
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
                    '${isLiked ? (likes + 1).toString() : likes.toString()} like',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Satoshi"),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Share.share('Check this out: ${widget.title} - ${widget.description}');
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 15),
        child: const Row(
          children: [
            Icon(Icons.share_outlined, size: 18, color: Colors.black),
            SizedBox(width: 5),
            Text(
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
      ),
    );
  }
}
