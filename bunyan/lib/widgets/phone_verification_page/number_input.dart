import 'package:bunyan/services/phone_verification_service.dart';
import 'package:bunyan/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatelessWidget {
  final TextEditingController controller;

  const NumberInput({super.key, required this.controller});

  Future<void> _checkPhoneNumber(
      BuildContext context, String phoneNumber) async {
    try {
      final data = await PhoneVerificationService()
          .findMemberByPhone(phoneNumber.replaceAll(' ', ''));

      // if (data['findMemberByPhone'] != null) {
      // If phone number is already registered, navigate to main page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This number is already registered.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, '/mainPage');
      // } else {
      //   // If phone number is not found, navigate to location selection
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Phone number not registered.'),
      //       backgroundColor: Colors.red,
      //       duration: Duration(seconds: 2),
      //     ),
      //   );
      // Navigator.pushReplacementNamed(context, '/locationSelection');
      // }
    } catch (error) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Error: $error'),
      //     backgroundColor: Colors.red,
      //   ),
      // );
      Navigator.pushReplacementNamed(context, '/locationSelection');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isValidPhoneNumber(String phoneNumber) {
      phoneNumber = phoneNumber.replaceAll(' ', '');
      return RegExp(r'^[6-9][0-9]{9}$').hasMatch(phoneNumber);
    }

    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFC8C8C8),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          // Country Code Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Color(0xFFC8C8C8), width: 0.5),
              ),
            ),
            child: const Row(
              children: [
                Image(
                  image: AssetImage('assets/images/flag-in.png'),
                  width: 30,
                  height: 20,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
                Text(
                  '+91',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF848484),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              autofocus: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
                PhoneNumberFormatter(),
              ],
              decoration: const InputDecoration(
                hintText: '1234 567 890',
                hintStyle: TextStyle(
                  color: Color(0xFFC8C8C8),
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final phoneNumber = controller.text.trim();

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
            child: const Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: Icon(
                Icons.arrow_circle_right_outlined,
                color: Color(0xFF9C9A9A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
