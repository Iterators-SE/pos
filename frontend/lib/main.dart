import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/datasources/authentication/authentication_datasource.dart';
import 'package:frontend/datasources/authentication/authentication_remote_datasource.dart';
import 'package:frontend/repositories/authentication_repository.dart';
import 'package:frontend/repositories/authentication_repository_implementation.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HttpLink _httpLink;
  GraphQLClient _client;
  IAuthenticationDataSource _authenticationDataSource;
  IAuthenticationRepository _authenticationRepository;
  FlutterSecureStorage _storage;

  @override
  void initState() {
    final scheme = Platform.isAndroid ? '10.0.0.2' : 'localhost';
    final uri =
        kReleaseMode ? 'WHEN_SERVER_IS_HOSTED' : 'http://$scheme:5000/graphql';

    _httpLink = HttpLink(uri);

    _client = GraphQLClient(
      cache: GraphQLCache(),
      link: _httpLink,
    );

    _storage = FlutterSecureStorage();

    _authenticationDataSource = AuthenticationRemoteDataSource(
      client: _client,
      storage: _storage,
    );

    _authenticationRepository = AuthenticationRepository(
      remote: _authenticationDataSource,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold() // Views here,
          ),
    );
  }
}
