import 'package:bunyan/graphql/queries/get_mahallus_query.dart' as queries;
import 'package:bunyan/services/graphql_service.dart';
import 'package:bunyan/utils/constants.dart';

class GetMahallusService {
  // Initialize GraphQLService
  final GraphQLService graphqlService = GraphQLService(
    baseUrl: backendUrl,
  );

  /// Fetch mahallus data
  Future<List<Map<String, dynamic>>?> getMahallus({
    required int limit,
    required int offset,
    Map<String, dynamic> filters = const {},
  }) async {
    try {
      // Send GraphQL request with variables
      final data = await graphqlService.postRequest(
        query: queries.getMahallus,
        variables: {
          "filters": filters,
          "limit": limit,
          "offset": offset,
        },
      );

      // Extract and return the mahallus data
      if (data['mahallus'] != null) {
        return List<Map<String, dynamic>>.from(data['mahallus']);
      } else {
        print('No mahallus data found');
        return null;
      }  
    } catch (error) {
      print('Error in getMahallus: $error');
      rethrow;
    }
  }
}
