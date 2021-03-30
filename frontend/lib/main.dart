import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';
import 'datasources/authentication/authentication_datasource.dart';
import 'datasources/authentication/authentication_remote_datasource.dart';
import 'repositories/authentication_repository.dart';
import 'repositories/authentication_repository_implementation.dart';
import 'views/auth/login_page.dart';

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
  // ignore: unused_field
  IAuthenticationRepository _authenticationRepository;
  SharedPreferences _storage;
  
  @override
  void initState() {
    final scheme = Platform.isAndroid ? '10.0.0.2' : 'localhost';
    final uri = kReleaseMode ? 'WHEN_SERVER_IS_HOSTED' : 'http://$scheme:5000/graphql';

    _httpLink = HttpLink(uri);

    _client = GraphQLClient(
      cache: GraphQLCache(),
      link: _httpLink,
    );

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
      providers: [
        Provider<User>(create:
        (context) => Provider.of<User>(context) ,),
        Provider<AuthenticationRemoteDataSource>(
          create:(context) => _authenticationDataSource,),
        Provider<AuthenticationRepository>(
          create: (context) => _authenticationRepository,
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginPage(),
          ),
    );
  }
}
