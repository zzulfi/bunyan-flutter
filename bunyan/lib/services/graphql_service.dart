import 'dart:convert';
import 'package:http/http.dart' as http;

class GraphQLService {
  final String baseUrl;

  GraphQLService({required this.baseUrl});

  Future<Map<String, dynamic>> postRequest({
    required String query,
    Map<String, dynamic>? variables,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'query': query,
          'variables': variables ?? {},
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['errors'] != null) {
          throw Exception(jsonResponse['errors'][0]['message']);
        }
        return jsonResponse['data'];
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
