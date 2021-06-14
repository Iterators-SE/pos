import 'dart:convert';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import 'authentication_datasource.dart';

class AuthenticationRemoteDataSource implements IAuthenticationDataSource {
  AuthenticationRemoteDataSource({this.client, this.storage});

  static final _posToken = 'POS_TOKEN';
  GraphQLClient client;
  final SharedPreferences storage;

  @override
  Future<bool> signup({String name, String email, String password}) async {
    try {
      final query = r'''
        mutation signup($data: SignupInput!) {
          action: signup(data: $data)
        }''';

      final response = await client.mutate(
        MutationOptions(
          document: gql(query),
          variables: {
            'data': {"name": name, "email": email, "password": password}
          },
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data["action"]);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> login({String email, String password}) async {
    try {
      final storage = await SharedPreferences.getInstance();

      final query = r'''
        mutation login($email: String!, $password: String!) {
          action: login(email: $email, password: $password)
        }''';

      final response = await client.mutate(
        MutationOptions(
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
  Future<bool> logout() async {
    try {
      final storage = await SharedPreferences.getInstance();
      return await storage.remove(_posToken);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getUser() async {
    try {
      final storage = await SharedPreferences.getInstance();
      return await storage.getString(_posToken);
    } catch (e) {
      rethrow;
    }
  }
}
