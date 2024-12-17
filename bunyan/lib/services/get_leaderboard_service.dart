import 'package:bunyan/graphql/queries/get_leaderboard_query.dart' as queries;
import 'package:bunyan/services/graphql_service.dart';
import 'package:bunyan/utils/constants.dart';

class GetLeaderboardService {
  // Initialize GraphQLService
  final GraphQLService graphqlService = GraphQLService(
    baseUrl: backendUrl,
  );

  /// Fetch leaderboard data
  Future<List<Map<String, dynamic>>?> getLeaderboard({
    required int limit,
    required int offset,
  }) async {
    try {
      // Send GraphQL request with variables
      final data = await graphqlService.postRequest(
        query: queries.getLeaderboard,
        variables: {
          "limit": limit,
          "offset": offset,
        },
      );

      // Extract and return the leaderboard data
      if (data['getLeaderboard'] != null) {
        return List<Map<String, dynamic>>.from(data['getLeaderboard']);
      } else {
        throw Exception('No leaderboard data found');
      }
    } catch (error) {
      print('Error in getLeaderboard: $error');
      rethrow;
    }
  }
}
