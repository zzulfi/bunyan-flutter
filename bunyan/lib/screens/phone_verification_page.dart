import 'package:bunyan/main.dart';
import 'package:bunyan/services/phone_verification_service.dart';
import 'package:bunyan/widgets/phone_verification_page/number_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneVerificationPage extends StatelessWidget {
  const PhoneVerificationPage({super.key});

  Future<void> _checkPhoneNumber(
      BuildContext context, String phoneNumber) async {
    try {
      final data = await PhoneVerificationService()
          .findMemberByPhone(phoneNumber.replaceAll(' ', ''));
  
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This number is already registered.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, '/mainPage');
    } catch (error) {
      Navigator.pushReplacementNamed(context, '/locationSelection');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    // Trigger loading simulation on first build
    if (appState.isSearchLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appState.simulateSearchLoading();
      });
    }

    // Define a TextEditingController for phone number input
    final TextEditingController phoneController = TextEditingController();

    // Set initial value to the controller from appState
    phoneController.text = appState.userDetails['phone'] ?? '';

    // Method to validate the phone number
    bool isValidPhoneNumber(String phoneNumber) {
      print('Phone number: $phoneNumber');
      phoneNumber = phoneNumber.replaceAll(' ', '');

      return RegExp(r'^[6-9][0-9]{9}$').hasMatch(phoneNumber);
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
                    '1 of 2',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF9C9A9A),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 100),
                  const Image(
                    image: AssetImage('assets/images/AssalamuAlaikkum.png'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Please enter your Whatsapp number',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFC8C8C8),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Pass the controller to NumberInput
                  NumberInput(controller: phoneController),
                  const SizedBox(height: 50),
                  // Continue button
                  GestureDetector(
                    onTap: () {
                      final phoneNumber = phoneController.text;

                      // Validate the phone number
                      if (isValidPhoneNumber(phoneNumber)) {
                        _checkPhoneNumber(context, phoneNumber);
                      } else {
                        // Show error if phone number is invalid
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a valid phone number'),
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
