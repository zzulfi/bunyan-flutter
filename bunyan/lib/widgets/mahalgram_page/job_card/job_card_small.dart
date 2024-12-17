import 'package:bunyan/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:share_plus/share_plus.dart';
class JobCardSmall extends StatefulWidget {
  final List<dynamic> jobs;  // Accept dynamic list instead of strictly typed List<Job>

  const JobCardSmall({
    super.key,
    required this.jobs, // Accept list of dynamic jobs
  });

  @override
  _JobCardSmallState createState() => _JobCardSmallState();
}

class _JobCardSmallState extends State<JobCardSmall> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Vacant Available',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Satoshi",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0CAF60),
                ),
              ),
              GestureDetector(
                onTap: () {
                  appState.setSelectedButtonIndex(2); // Update the button index
                },
                child: const Text(
                  "View more",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Satoshi",
                    color: Color(0xFFC8C8C8),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300, // Adjust height to fit content
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.jobs.length,
            itemBuilder: (context, index) {
              // We no longer need to explicitly reference a Job model
              var job = widget.jobs[index];
              return JobCardContent(
                jobId: job['jobId'] ?? 0,
                title: job['title'] ?? '',
                description: job['description'] ?? '',
                location: job['location'] ?? '',
                skills: List<String>.from(job['skills'] ?? []),
                postedAt: job['postedAt'] ?? '',
              );
            },
          ),
        ),
      ],
    );
  }
}

class JobCardContent extends StatelessWidget {
  final int jobId;
  final String title;
  final String description;
  final String location;
  final List<String> skills;
  final String postedAt;

  const JobCardContent({
    super.key,
    required this.jobId,
    required this.title,
    required this.description,
    required this.location,
    required this.skills,
    required this.postedAt,
  });

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isLoading = appState.isPostLoading(jobId);

    if (!appState.postLoadingState.containsKey(jobId)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appState.simulatePostLoading(jobId);
      });
    }

    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Stack(
        children: [
          const Positioned(
            bottom: -130,
            right: -150,
            child: Icon(
              Icons.luggage,
              size: 330,
              color: Color.fromRGBO(156, 104, 104, 0.068),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 17, top: 25, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JobContentSection(
                  isLoading: isLoading,
                  title: title,
                  description: description,
                  location: location,
                  skills: skills,
                  postedAt: postedAt,
                ),
                JobLocationSection(isLoading: isLoading, location: location),
                JobContactSection(isLoading: isLoading, jobId: jobId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class JobContentSection extends StatelessWidget {
  final bool isLoading;
  final String title;
  final String description;
  final String location;
  final List<String> skills;
  final String postedAt;

  const JobContentSection({
    super.key,
    required this.isLoading,
    required this.title,
    required this.description,
    required this.location,
    required this.skills,
    required this.postedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLoading
            ? Column(
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
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Posted on: ",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6A55),
                          fontFamily: "Satoshi",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: "Satoshi",
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 11.2,
                      color: Colors.black54,
                      fontFamily: "Satoshi",
                    ),
                  ),
                ],
              ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class JobLocationSection extends StatelessWidget {
  final bool isLoading;
  final String location;

  const JobLocationSection({super.key, required this.isLoading, required this.location});

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
                flex: 1,
                child: isLoading
                    ? Shimmer.fromColors(
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
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
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
                            location,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              height: 1.3,
                              fontFamily: "Satoshi",
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class JobContactSection extends StatelessWidget {
  final bool isLoading;
  final int jobId;

  const JobContactSection({super.key, required this.isLoading, required this.jobId});

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
              const SizedBox(width: 10), 

              // Share Button
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () => _sharePost(context, jobId),
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFF0F0F0),
                    ),
                    child: const Center(
                      child: Icon(Icons.share_outlined,
                          size: 18, color: Color(0xFF007AFF)),
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
    Share.share('Check out this amazing post! $postUrl',
        subject: 'Amazing Post!');
  }
}
