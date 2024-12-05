import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';
import 'widgets/bottom_navigation_bar1.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class AppState extends ChangeNotifier {
  int _selectedNavBarIndex = 1; // Default selected index (Search)
  int _selectedButtonIndex = 0; // Default index for ButtonRow (All Posts)
  final Set<int> _likedPosts = {}; // Track liked posts
  final Map<int, bool> _postLoadingState =
      {}; // Track loading state for each post

  int get selectedNavBarIndex => _selectedNavBarIndex;
  int get selectedButtonIndex => _selectedButtonIndex;
  Set<int> get likedPosts => _likedPosts;
  bool isPostLoading(int postId) => _postLoadingState[postId] ?? true;

  void setSelectedNavBarIndex(int index) {
    _selectedNavBarIndex = index;
    notifyListeners();
  }

  void setSelectedButtonIndex(int index) {
    _selectedButtonIndex = index;
    notifyListeners();
  }

  void toggleLike(int postId) {
    if (_likedPosts.contains(postId)) {
      _likedPosts.remove(postId);
    } else {
      _likedPosts.add(postId);
    }
    notifyListeners();
  }

  void setPostLoading(int postId, bool isLoading) {
    _postLoadingState[postId] = isLoading;
    notifyListeners();
  }

  void simulatePostLoading(int postId) {
    setPostLoading(postId, true);
    Future.delayed(const Duration(seconds: 3), () {
      setPostLoading(postId, false);
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF5F5F5),
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 100),
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [
                        Color(0xFFB2B79C),
                        Color(0xFF7B9374),
                        Color(0xFFE2F2CE),
                      ],
                      stops: [0.0, 0.42, 0.95],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: const Text(
                    '#MahalGram',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const ButtonRow(),
                const SizedBox(height: 4),
                const PostCard(postId: 1),
                const EventCard(eventId: 2),
                const EventCard(eventId: 1),
                // const PostCard(postId: 2),
                // const PostCard(postId: 3),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

class ButtonRow extends StatelessWidget {
  const ButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonItem(
                label: 'All Posts',
                index: 0,
                isActive: appState.selectedButtonIndex == 0),
            const SizedBox(width: 5),
            ButtonItem(
                label: 'Events',
                index: 1,
                isActive: appState.selectedButtonIndex == 1),
            const SizedBox(width: 5),
            ButtonItem(
                label: 'Jobs',
                index: 2,
                isActive: appState.selectedButtonIndex == 2),
          ],
        );
      },
    );
  }
}

class ButtonItem extends StatelessWidget {
  final String label;
  final int index;
  final bool isActive;

  const ButtonItem(
      {super.key,
      required this.label,
      required this.index,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor:
            isActive ? const Color(0xFF0CAF60) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        side: BorderSide(
          color: isActive ? const Color(0xFF0CAF60) : Colors.grey,
          width: 0.5,
        ),
      ),
      onPressed: () {
        appState.setSelectedButtonIndex(index);
      },
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey,
          fontSize: 12,
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final int postId;

  const PostCard({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isLiked = appState.likedPosts.contains(postId);
    final isLoading = appState.isPostLoading(postId);

    // Simulate loading state on initialization
    if (!appState._postLoadingState.containsKey(postId)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appState.simulatePostLoading(postId);
      });
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
                          image: NetworkImage(
                              'https://via.placeholder.com/35'), // Replace with actual profile image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              const SizedBox(width: 6),
              isLoading
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
                    ),
              const Spacer(),
              isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 20,
                        width: 20,
                        color: Colors.grey.shade300,
                      ),
                    )
                  : const Icon(Icons.more_vert, size: 20, color: Colors.black),
            ],
          ),
          const Divider(color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 5),
          // Body
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
                ),
          const SizedBox(height: 10),
          // Image
          isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: Colors.grey.shade300,
                    ),
                  ),
                )
              : Container(
                  height: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    image: const DecorationImage(
                      image:
                          NetworkImage('https://via.placeholder.com/400x210'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          const SizedBox(height: 10),
          // Footer
          Row(
            children: [
              GestureDetector(
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
              ),
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
}

class JobCard extends StatelessWidget {
  final int jobId;
  const JobCard({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isLiked = appState.likedPosts.contains(jobId);
    final isLoading = appState.isPostLoading(jobId);

    // Simulate loading state on initialization
    if (!appState._postLoadingState.containsKey(jobId)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appState.simulatePostLoading(jobId);
      });
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
          // Profile
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     isLoading
          //         ? Shimmer.fromColors(
          //             baseColor: Colors.grey.shade300,
          //             highlightColor: Colors.grey.shade100,
          //             child: Container(
          //               width: 35,
          //               height: 35,
          //               decoration: BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 color: Colors.grey.shade300,
          //               ),
          //             ),
          //           )
          //         : Container(
          //             width: 35,
          //             height: 35,
          //             decoration: const BoxDecoration(
          //               shape: BoxShape.circle,
          //               image: DecorationImage(
          //                 image: NetworkImage(
          //                     'https://via.placeholder.com/35'), // Replace with actual profile image URL
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //           ),
          //     const SizedBox(width: 6),
          //     isLoading
          //         ? Shimmer.fromColors(
          //             baseColor: Colors.grey.shade300,
          //             highlightColor: Colors.grey.shade100,
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   height: 12,
          //                   width: 100,
          //                   color: Colors.grey.shade300,
          //                 ),
          //                 const SizedBox(height: 5),
          //                 Container(
          //                   height: 10,
          //                   width: 50,
          //                   color: Colors.grey.shade300,
          //                 ),
          //               ],
          //             ),
          //           )
          //         : const Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 "Profile Name",
          //                 style: TextStyle(
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.black,
          //                   fontFamily: "Satoshi",
          //                 ),
          //               ),
          //               Text(
          //                 "2h ago",
          //                 style: TextStyle(
          //                   fontSize: 10,
          //                   color: Colors.grey,
          //                   fontFamily: "Satoshi",
          //                 ),
          //               ),
          //             ],
          //           ),
          //     const Spacer(),
          //     isLoading
          //         ? Shimmer.fromColors(
          //             baseColor: Colors.grey.shade300,
          //             highlightColor: Colors.grey.shade100,
          //             child: Container(
          //               height: 20,
          //               width: 20,
          //               color: Colors.grey.shade300,
          //             ),
          //           )
          //         : const Icon(Icons.more_vert, size: 20, color: Colors.black),
          //   ],
          // ),
          // const Divider(color: Colors.grey, thickness: 0.5),
          // const SizedBox(height: 5),

          // Image
          isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: Colors.grey.shade300,
                    ),
                  ),
                )
              : Container(
                  height: 210,
                  decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.circular(17),
                    image: DecorationImage(
                      image:
                          NetworkImage('https://via.placeholder.com/400x210'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          // Body
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
                ),
          const SizedBox(height: 10),

          const SizedBox(height: 10),
          // Footer
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  appState.toggleLike(jobId);
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
              ),
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
}

class EventCard extends StatefulWidget {
  final int eventId;

  const EventCard({super.key, required this.eventId});

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isInterested = false; // Track the state of the "Interested" button

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    // final isLiked = appState.likedPosts.contains(widget.eventId);
    final isLoading = appState.isPostLoading(widget.eventId);

    // Simulate loading state on initialization
    if (!appState._postLoadingState.containsKey(widget.eventId)) {
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
          Stack(
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
                          image: NetworkImage(
                              'https://via.placeholder.com/400x210'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              // Share Icon
              Positioned(
                top: 13,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    // Handle share action
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x4D9E9E9E), // Equivalent to Colors.grey.withOpacity(0.3)
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.share_outlined,
                      size: 24,
                      color: Color(0xFF0CAF60),
                    ),
                  ),
                ),
              ),
              // Interested Button
              // Positioned(
              //   top: 5,
              //   left: 10,
              //   child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: isInterested
              //             ? const Color(
              //                 0xFF0CAF60) // Green background when clicked
              //             : const Color(0xFFF6F6F6), // Default white background
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 12, vertical: 6),
              //       ),
              //       onPressed: () {
              //         setState(() {
              //           isInterested = !isInterested; // Toggle the state
              //         });
              //       },
              //       child: Row(
              //         children: [
              //           Icon(Icons.bookmarks, size: 18, color: isInterested ? Colors.white : const Color(0xFF0CAF60)),
              //           SizedBox(width: 2),
              //           Text(
              //             "Interested",
              //             style: TextStyle(
              //               fontSize: 14,
              //               color: isInterested
              //                   ? Colors.white // White text when clicked
              //                   : const Color(
              //                       0xFF0CAF60), // Green text otherwise
              //             ),
              //           )
              //         ],
              //       )
              //       ),
              // ),
            ],
          ),

          // Content Section
          Padding(
            padding:
                const EdgeInsets.only(bottom: 17, left: 17, right: 17, top: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date and Title
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

                // Profile Section
                Row(
                  children: [
                    // Profile Image
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
                                image: NetworkImage(
                                    'https://via.placeholder.com/35'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    const SizedBox(width: 10),

                    // Name and Time
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

                    // Address
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
