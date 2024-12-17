import 'package:bunyan/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:bunyan/utils/datetime.dart';

class EventCard extends StatefulWidget {
  final int eventId;
  final String title;
  final String description;
  final String startingAt;
  final String location;
  final String postedAt;
  final String eventImageURL;

  const EventCard({
    super.key,
    required this.eventId,
    required this.title,
    required this.description,
    required this.startingAt,
    required this.location,
    required this.postedAt,
    required this.eventImageURL,
  });

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isLoading = appState.isPostLoading(widget.eventId);

    if (!appState.postLoadingState.containsKey(widget.eventId)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appState.simulatePostLoading(widget.eventId);
      });
    }

    return GestureDetector(
      onTap: () {
        if (!isLoading) {
          // Navigate to event details or perform an action.
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            _EventImageSection(
              isLoading: isLoading,
              eventImageURL: widget.eventImageURL,
            ),

            // Content Section
            _EventContentSection(
              isLoading: isLoading,
              title: widget.title,
              description: widget.description,
              startingAt: formatTimestamp(widget.startingAt),
              
            ),

            // Profile Section
            _EventProfileSection(
              isLoading: isLoading,
              location: widget.location,
              postedAt: formatTimestamp(widget.postedAt),
            ),
          ],
        ),
      ),
    );
  }
}

// Image Section Widget
class _EventImageSection extends StatelessWidget {
  final bool isLoading;
  final String eventImageURL;

  const _EventImageSection({
    required this.isLoading,
    required this.eventImageURL,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      child: isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 200,
                color: Colors.grey.shade300,
              ),
            )
          : Image.network(
              eventImageURL,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
    );
  }
}

// Content Section Widget
class _EventContentSection extends StatelessWidget {
  final bool isLoading;
  final String title;
  final String description;
  final String startingAt;

  const _EventContentSection({
    required this.isLoading,
    required this.title,
    required this.description,
    required this.startingAt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 20,
                    width: 150,
                    color: Colors.grey.shade300,
                  ),
                )
              : Text(
                  startingAt,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          const SizedBox(height: 8),
          isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 20,
                    width: 200,
                    color: Colors.grey.shade300,
                  ),
                )
              : Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
          const SizedBox(height: 8),
          isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 14,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                  ),
                )
              : Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
        ],
      ),
    );
  }
}

// Profile Section Widget
class _EventProfileSection extends StatelessWidget {
  final bool isLoading;
  final String location;
  final String postedAt;

  const _EventProfileSection({
    required this.isLoading,
    required this.location,
    required this.postedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                  ),
                )
              : const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/40'), // Replace with actual user profile image URL.
                ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 12,
                          width: 100,
                          color: Colors.grey.shade300,
                        ),
                      )
                    : Text(
                        location,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                const SizedBox(height: 5),
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 12,
                          width: 60,
                          color: Colors.grey.shade300,
                        ),
                      )
                    : Text(
                        postedAt,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}