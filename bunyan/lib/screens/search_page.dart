import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bunyan/widgets/search_page/profile_details.dart';
import 'package:bunyan/widgets/search_page/profile_skeleton.dart';
import 'package:bunyan/widgets/search_page/search_section.dart';
import 'package:bunyan/main.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF5F5F5),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                'Search',
                style: TextStyle(
                  fontSize: 45,
                  color: Color(0xFF323232),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Satoshi',
                ),
              ),
              const SizedBox(height: 8),
              const SearchSection(),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(top: 17, left: 17, right: 17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: appState.isSearchLoading
                      ? List.generate(5, (_) => const ProfileSkeleton())
                      : appState.searchResults.isEmpty
                          ? [const Padding(padding: EdgeInsets.only(bottom: 17), child: Center(child: Text('No results found')))]
                          : appState.searchResults
                              .map<Widget>((result) => ProfileDetails(
                                    postId: result[
                                        'id'], // Replace 'regNo' with the actual key for post ID if needed
                                    name: result['name'] ??
                                        'Unknown Name', // Replace 'name' with the correct key
                                    place: result['place'] ??
                                        'Unknown Place', // Replace 'place' with the correct key
                                  ))
                              .toList(),
                ),
              ),
              const SizedBox(height: 65),
            ],
          ),
        ),
      ),
    );
  }
}
