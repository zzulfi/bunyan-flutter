import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import '../main.dart';

// // Dummy AppState class for example purposes
// class AppState with ChangeNotifier {
//   Map<int, bool> _postLoadingState = {};

//   bool isPostLoading(int eventId) {
//     return _postLoadingState[eventId] ?? false;
//   }

//   void simulatePostLoading(int eventId) {
//     _postLoadingState[eventId] = true;
//     notifyListeners();
//   }
// }

class EventCard extends StatefulWidget {
  final int eventId;

  const EventCard({super.key, required this.eventId});

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isLoading = appState.isPostLoading(widget.eventId);

    // if (!appState._postLoadingState.containsKey(widget.eventId)) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     appState.simulatePostLoading(widget.eventId);
    //   });
    // }
    if (!appState.postLoadingState.containsKey(widget.eventId)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appState.simulatePostLoading(widget.eventId);
      });
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          EventImageSection(isLoading: isLoading),

          // Content Section
          EventContentSection(isLoading: isLoading),

          // Profile Section

          EventProfileSection(isLoading: isLoading),
        ],
      ),
    );
  }
}

// Image Section Widget
class EventImageSection extends StatelessWidget {
  final bool isLoading;

  const EventImageSection({
    super.key,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 210,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: Colors.grey.shade300,
                  ),
                ),
              )
            : Container(
                height: 210,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: NetworkImage('https://via.placeholder.com/400x210'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
      ],
    );
  }
}

// Content Section Widget
class EventContentSection extends StatelessWidget {
  final bool isLoading;

  const EventContentSection({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 17, top: 13),
      child: Column(
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
              : const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "20 Nov at 09:00",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF6A55),
                        fontFamily: "Satoshi",
                      ),
                    ),
                    Text(
                      "Event Title",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "Satoshi",
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "This is a sample description of the event. It gives an overview of what this event is about.",
                      style: TextStyle(
                        fontSize: 11.2,
                        color: Colors.black54,
                        fontFamily: "Satoshi",
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

// Profile Section Widget
class EventProfileSection extends StatelessWidget {
  final bool isLoading;

  const EventProfileSection({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 17,
        left: 17,
        right: 17,
      ),
      child: Row(
        children: [
          isLoading
              ? Shimmer.fromColors(
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
                )
              : Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://via.placeholder.com/35'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
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
                : const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Poozhikkunnel Mahallu Juma Masjid",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                  ),
          ),
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
                  )
                : const Text(
                    "Valancheri, Valanchery, India 676552, Kerala",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontFamily: "Satoshi",
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
