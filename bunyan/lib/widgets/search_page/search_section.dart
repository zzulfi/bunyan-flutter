import 'package:bunyan/services/get_mahallus_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bunyan/main.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  _SearchSectionState createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final TextEditingController _controller = TextEditingController();
  final GetMahallusService _mahallusService = GetMahallusService();
  bool _hasValue = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasValue = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearch(String query) async {
    final appState = Provider.of<AppState>(context, listen: false);

    if (query.isEmpty) {
      appState.updateSearchResults([]);
      return;
    }

    appState.setSearchLoading(true);

    try {
      final results = await _mahallusService.getMahallus(
        limit: 10,
        offset: 0,
        filters: {
          "name": {"contains": query, "mode": "insensitive"}
        },
      );

      final filteredResults = results
              ?.where((item) => item['name']
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList() ??
          [];
      appState.updateSearchResults(filteredResults);
    } catch (e) {
      print('Error during search: $e');
      appState.updateSearchResults([]);
    } finally {
      appState.setSearchLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFC8C8C8),
                width: 1,
              ),
            ),
            child: TextField(
              controller: _controller,
              onChanged: _onSearch,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Satoshi',
                  color: Color(0xFF848484),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                  color: Color.fromARGB(255, 99, 201, 123),
                ),
                suffixIcon: _hasValue
                    ? GestureDetector(
                        onTap: () {
                          _controller.clear();
                          _onSearch(''); // Clear the search results
                        },
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: Color(0xFF848484),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
