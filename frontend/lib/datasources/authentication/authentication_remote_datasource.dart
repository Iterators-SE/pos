import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql/client.dart';

import '../../models/user.dart';
import 'authentication_datasource.dart';

class AuthenticationRemoteDataSource implements IAuthenticationDataSource {
  AuthenticationRemoteDataSource({this.client, this.storage});

  final _posToken = 'POS_TOKEN';
  final GraphQLClient client;
  final FlutterSecureStorage storage;

  @override
  Future<bool> signup({String name, String email, String password}) async {
    try {
      final query = r'''
        mutation signup($name: String!, $email: String!, $password: String!) {
          action: signup(name: $name, email: $email, password: $password)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {'name': name, 'email': email, 'password': password},
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
    // TODO: implement login and replace [user] with actual data
    final user = User(token: 'TOKEN_HERE');

    // On success
    await storage.write(key: _posToken, value: user.token);
    return user;
  }

  @override
  Future<bool> logout() async {
    // TODO: implement logout

    // On success
    await storage.delete(key: _posToken);
    throw UnimplementedError();
  }
}
