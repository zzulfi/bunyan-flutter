import 'package:bunyan/main.dart';
import 'package:bunyan/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bunyan/widgets/fatwa_help_page/fatwa_card.dart';
import 'package:bunyan/widgets/fatwa_help_page/ask_box.dart';
import 'package:bunyan/services/get_fatwas_service.dart';
import 'package:bunyan/utils/datetime.dart';

class FatwaHelpPage extends StatefulWidget {
  const FatwaHelpPage({super.key});

  @override
  _FatwaHelpPageState createState() => _FatwaHelpPageState();
}

class _FatwaHelpPageState extends State<FatwaHelpPage>
    with SingleTickerProviderStateMixin {
  late AppState _appState;
  final GetFatwasService fatwasService = GetFatwasService();

  List<Map<String, dynamic>> fatwas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initialize AppState with this TickerProvider
    _appState = AppState(vsync: this);

    // Fetch fatwas on initialization
    fetchFatwas();
  }

  Future<void> fetchFatwas() async {
    try {
      final data = await fatwasService.getFatwas(limit: 10, offset: 0);
      setState(() {
        fatwas = data ?? [];
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching fatwas: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>.value(
      value: _appState,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: const Color(0xFFF5F5F5),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 70),
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            colors: [
                              Color(0xFFB2B79C),
                              Color(0xFF7B9374),
                              Color(0xFFE2F2CE),
                            ],
                            stops: [0.0, 0.42, 0.85],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: const Center(
                          child: Text(
                            'Fatwa Help',
                            style: TextStyle(
                              fontSize: 35,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Satoshi',
                            ),
                          ),
                        ),
                      ),
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: primaryGreen,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: fatwas.length,
                              itemBuilder: (context, index) {
                                final fatwa = fatwas[index];
                                final askedAt = formatTimestamp(
                                    fatwa['askedAt']); // Format the timestamp
                                return GestureDetector(
                                  onTap: () {
                                    _appState.toggleExpansion();
                                  },
                                  child: FatwaCard(
                                    bgImage: index % 2 == 0
                                        ? 'assets/images/fatwa_green_gradient.png'
                                        : 'assets/images/fatwa_violet_gradient.png',
                                    question: fatwa['question'] ??
                                        'No question available',
                                    answer: fatwa['answer'] ??
                                        'No answer available',
                                    date: askedAt,
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: AskBox(),
            ),
            const SizedBox(height: 75),
          ],
        ),
      ),
    );
  }
}
