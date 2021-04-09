import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import 'authentication_datasource.dart';

class AuthenticationRemoteDataSource implements IAuthenticationDataSource {
  AuthenticationRemoteDataSource({this.client, this.storage});

  static final _posToken = 'POS_TOKEN';
  final GraphQLClient client;
  final SharedPreferences storage;

  @override
  Future<bool> signup({String name, String email, String password}) async {
    try {
      final query = r'''
        mutation signup($data: SignupInput!) {
          action: signup(data: $data)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {
            'data': {'name': name, 'email': email, 'password': password}
          },
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      // Can be extracted to a model
      final data = jsonEncode(response.data['signup']);
      return jsonDecode(data); // or data.toLowerCase() == 'true'
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> login({String email, String password}) async {
    final storage = await SharedPreferences.getInstance();

    try {
      final query = r'''
        mutation login($email: String!, $password: String!) {
          action: login(email: $email, password: $password)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {'email': email, 'password': password},
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final user = User(token: response.data["action"]);
      await storage.setString(_posToken, user.token);
      
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await storage.remove(_posToken);
  }

  @override
  Future<dynamic> getUser() async {
    final storage = await SharedPreferences.getInstance();
    return await storage.getString(_posToken);
  }
}
