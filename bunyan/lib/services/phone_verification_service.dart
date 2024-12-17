import 'package:bunyan/graphql/mutation/find_member_by_phone.dart' as queries;
import 'package:bunyan/services/graphql_service.dart';
import 'package:bunyan/utils/constants.dart';

class PhoneVerificationService {
  // Constructor to initialize GraphQLService
  final GraphQLService graphqlService = GraphQLService(
    baseUrl: backendUrl,
  );

  Future<Map<String, dynamic>?> findMemberByPhone(String phoneNumber) async {
    try {
      // Make the GraphQL request
      final data = await graphqlService.postRequest(
        query: queries.findMemberByPhone,
        variables: {'phone': phoneNumber},
      );

      // Check if the response contains the desired data
      if (data['findMemberByPhone'] != null) {
        print('Phone number found: ${data['findMemberByPhone']}');
        return data['findMemberByPhone'];
      } else {
        throw Exception('Phone number not found');
      }
    } catch (error) {
      print('Error in findMemberByPhone: $error');
      rethrow; // Re-throwing the error to handle it upstream
    }
  }
}
