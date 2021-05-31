import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../../models/user_profile.dart';
import 'profile_datasource.dart';

class ProfileRemoteDatasource implements IProfileRemoteDataSource {
  ProfileRemoteDatasource({this.client});

  final GraphQLClient client;

  Future<UserProfile> getProfileInfo() async {
    try {
      final query = r'''
        query getUserDetails(){
          action: getUserDetails(){
            id,
            name,
            email,
            receiptMessage,
            address
          }
      }''';

      final response = await client.query(
        QueryOptions(document: gql(query)),
      );

      // print(await response);

      if (response.hasException) {
        throw response.exception;
      }

      var data = jsonEncode(response.data['action']);
      return UserProfile.fromJson(jsonDecode(data));
    } catch (e) {
      rethrow;
    }
  }

  Future<UserProfile> updateProfileInfo(UserProfile userProfile) async {
      try {
      final query = r'''
        mutation changeUserDetails($data: ChangeUserDetailsInput!){
          action: changeUserDetails(data: $data){
            id,
            name,
            email,
            receiptMessage,
            address
          }
      }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {
            'data': {
              "name": userProfile.name,
              "email": userProfile.email,
              "address": userProfile.address,
              "receiptMessage": userProfile.receiptMessage
            }
          }
        ),
      );

      // print(await response);

      if (response.hasException) {
        throw response.exception;
      }

      var data = jsonEncode(response.data['action']);
      return UserProfile.fromJson(jsonDecode(data));
    } catch (e) {
      rethrow;
    }
  }
}
