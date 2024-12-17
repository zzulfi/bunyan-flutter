import 'package:bunyan/graphql/queries/get_shuffled_content.dart' as queries;
import 'package:bunyan/services/graphql_service.dart';
import 'package:bunyan/utils/constants.dart';

class GetShuffledContentService {
  // Initialize GraphQLService
  final GraphQLService graphqlService = GraphQLService(
    baseUrl: backendUrl,
  );

  /// Fetch shuffled content
  Future<Map<String, dynamic>?> getShuffledContent({
    int eventLimit = 10,
    int jobLimit = 10,
    int postLimit = 10,
  }) async {
    try {
      // Send GraphQL request with variables
      final data = await graphqlService.postRequest(
        query: queries.getShuffledContent,
        variables: {
          "eventLimit": eventLimit,
          "jobLimit": jobLimit,
          "postLimit": postLimit,
        },
      );

      // Check and return data
      if (data['getShuffledContent'] != null) {
        return data['getShuffledContent'] as Map<String, dynamic>;
      } else {
        print('No shuffled content found');
        return null;
      }
    } catch (error) {
      print('Error in getShuffledContent: $error');
      rethrow;
    }
  }
}
