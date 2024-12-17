import 'package:bunyan/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bunyan/widgets/location_selection_page/district_drodpdown.dart';

class LocationSelectionPage extends StatelessWidget {
  const LocationSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    // Trigger loading simulation on first build
    if (appState.isSearchLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appState.simulateSearchLoading();
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF5F5F5),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 45),
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 150),
                  const Text(
                    '2 of 2',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF9C9A9A),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 120),
                  const Text(
                    'Please select your district',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFC8C8C8),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 20),
                  // // Phone number input with dropdown
                  // const NumberInput(),
                  const DistrictDropdown(),
                  const SizedBox(height: 30),
                  // Continue button
                  GestureDetector(
                    onTap: () {
                      if (appState.getUserDetails['district'] != '') {
                        Navigator.pushReplacementNamed(context, '/mainPage');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please select a district',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF0CAF60),
                      ),
                      child: const Center(
                        child: Text(
                          'Continue',
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
                  const SizedBox(height: 10),
                  const Text(
                    'or',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFFC8C8C8),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/mainPage');
                    },
                    child: const Text(
                      'Skip this step',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFC8C8C8),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class LocationSelectionPage extends StatelessWidget {
//   const LocationSelectionPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pushReplacementNamed(context, '/mainPage');
//           },
//           child: const Text('Continue'),
//         ),
//       ),
//     );
//   }
// }
