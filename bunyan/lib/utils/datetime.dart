// utils/datetime.dart
import 'package:intl/intl.dart';

String formatTimestamp(String timestamp) {
  // Parse the timestamp string into a DateTime object
  DateTime dateTime = DateTime.parse(timestamp);

  // Format the DateTime object into the desired format
  return DateFormat('d MMM yyyy').format(dateTime);
}
