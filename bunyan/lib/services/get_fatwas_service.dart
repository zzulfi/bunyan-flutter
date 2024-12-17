import 'package:bunyan/graphql/queries/get_fatwas_query.dart' as queries;
import 'package:bunyan/services/graphql_service.dart';
import 'package:bunyan/utils/constants.dart';

class GetFatwasService {
  // Initialize GraphQLService
  final GraphQLService graphqlService = GraphQLService(
    baseUrl: backendUrl,
  );

  /// Fetch fatwas data
  Future<List<Map<String, dynamic>>?> getFatwas({
    required int limit,
    required int offset,
  }) async {
    try {
      // Send GraphQL request with variables
      final data = await graphqlService.postRequest(
        query: queries.getFatwas,
        variables: {
          "filters": {
            "status": "ANSWERED",
          },
          "limit": limit,
          "offset": offset,
        },
      );

      // Extract and return the fatwas data
      if (data['fatwas'] != null) {
        return List<Map<String, dynamic>>.from(data['fatwas']);
      } else {
        throw Exception('No fatwas data found');
      }
    } catch (error) {
      print('Error in getFatwas: $error');
      rethrow;
    }
  }
}
