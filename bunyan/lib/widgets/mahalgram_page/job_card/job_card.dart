import 'package:bunyan/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:share_plus/share_plus.dart';

class JobCard extends StatefulWidget {
  final int jobId;
  final String title;
  final String description;
  final String location;
  final List<String> skills;
  final String postedAt;

  const JobCard({
    super.key,
    required this.jobId,
    required this.title,
    required this.description,
    required this.location,
    required this.skills,
    required this.postedAt,
  });

  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    if (!appState.postLoadingState.containsKey(widget.jobId)) {
      appState.simulatePostLoading(widget.jobId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isLoading = appState.isPostLoading(widget.jobId);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: -130,
            right: -150,
            child: Icon(
              Icons.luggage,
              size: 330,
              color: Color.fromRGBO(156, 104, 104, 0.068),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 17, right: 17, top: 25, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JobContentSection(isLoading: isLoading),
                JobLocationSection(isLoading: isLoading),
                JobContactSection(isLoading: isLoading, jobId: widget.jobId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Content Section Widget
class JobContentSection extends StatelessWidget {
  final bool isLoading;

  const JobContentSection({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLoading ? _buildLoadingContent() : _buildJobContent(),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildLoadingContent() {
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

  Widget _buildJobContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Posted on:",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9C9A9A),
                    fontFamily: "Satoshi",
                  ),
                ),
                Text(
                  "20/11/2020",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6A55),
                    fontFamily: "Satoshi",
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "Job Title",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "Satoshi",
          ),
        ),
        SizedBox(height: 5),
        Text(
          "This is a sample description of the job. It provides details about the position and what’s required.",
          style: TextStyle(
            fontSize: 11.2,
            color: Colors.black54,
            fontFamily: "Satoshi",
          ),
        ),
      ],
    );
  }
}

// Job Location Section Widget
class JobLocationSection extends StatelessWidget {
  final bool isLoading;

  const JobLocationSection({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: isLoading ? _buildLoadingLocation() : _buildLocation(),
              ),
              Expanded(
                flex: 1,
                child: isLoading
                    ? _buildLoadingRequirements()
                    : _buildRequirements(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingLocation() {
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

  Widget _buildLocation() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 15,
              color: Color(0xFF9C9A9A),
            ),
            SizedBox(width: 5),
            Text(
              "Location",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF9C9A9A),
                fontFamily: "Satoshi",
              ),
            ),
          ],
        ),
        Text(
          "San Francisco, CA",
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            height: 1.3,
            fontFamily: "Satoshi",
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingRequirements() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 12,
            width: 150,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 5),
          Container(
            height: 12,
            width: 150,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  Widget _buildRequirements() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.checklist_outlined,
              size: 15,
              color: Color(0xFF9C9A9A),
            ),
            SizedBox(width: 5),
            Text(
              "Requirements",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF9C9A9A),
                fontFamily: "Satoshi",
              ),
            ),
          ],
        ),
        Text(
          "Good manners, communication skills",
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            height: 1.3,
            fontFamily: "Satoshi",
          ),
        ),
      ],
    );
  }
}

// Job Contact Section Widget
class JobContactSection extends StatelessWidget {
  final bool isLoading;
  final int jobId;

  const JobContactSection(
      {super.key, required this.isLoading, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              // Contact Button
              Expanded(
                flex: 9,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF0CAF60),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Contact',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              // Share Button
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () => _sharePost(context, jobId),
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFF0F0F0),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.share_outlined,
                        size: 18,
                        color: Color(0xFF007AFF),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _sharePost(BuildContext context, int jobId) {
    final postUrl = "https://example.com/post/$jobId";
    Share.share('Check out this amazing job posting! $postUrl',
        subject: 'Amazing Job!');
  }
}
