import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-digit characters
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Limit to 10 digits
    if (digitsOnly.length > 10) {
      digitsOnly = digitsOnly.substring(0, 10);
    }

    // Format as "1234 567 890"
    String formatted = digitsOnly.replaceAllMapped(
        RegExp(r'(\d{1,4})(\d{1,3})?(\d{1,3})?'), (Match match) {
      String part1 = match.group(1) ?? '';
      String part2 = match.group(2) ?? '';
      String part3 = match.group(3) ?? '';
      return [part1, part2, part3].where((part) => part.isNotEmpty).join(' ');
    });

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
