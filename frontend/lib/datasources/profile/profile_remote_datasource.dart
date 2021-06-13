import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../../models/user_profile.dart';
import 'profile_datasource.dart';

class ProfileRemoteDatasource implements IProfileRemoteDataSource {
  ProfileRemoteDatasource({this.client});

  GraphQLClient client;

  Future<UserProfile> getProfileInfo() async {
    try {
      final query = '''
        query {
          getUserDetails{
            id,
            name,
            email,
            receiptMessage,
            address
          }
        }
      ''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      // print(await response);

      if (response.hasException) {
        throw response.exception;
      }

      var data = jsonEncode(response.data['getUserDetails']);
      return UserProfile.fromJson(jsonDecode(data));
    } catch (e) {
      rethrow;
    }
  }

  Future<UserProfile> updateProfileInfo(UserProfile userProfile) async {
    try {
      final query = '''
        mutation {
          changeUserDetails(data: {
            name: "${userProfile.name}",
            email: "${userProfile.email}",
            address:"${userProfile.address}",
            receiptMessage: "${userProfile.receiptMessage}"
          }){
            id,
            name,
            email,
            receiptMessage,
            address
          }
        }
      ''';

      final response = await client.mutate(
        MutationOptions(
          document: gql(query),
          fetchPolicy: FetchPolicy.networkOnly
        ),
      );

      // print(await response);

      if (response.hasException) {
        throw response.exception;
      }

      var data = jsonEncode(response.data['changeUserDetails']);
      return UserProfile.fromJson(jsonDecode(data));
    } catch (e) {
      rethrow;
    }
  }
}
