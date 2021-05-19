import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:frontend/features/inventory/add/add_products.dart';
//import 'package:frontend/features/inventory/details/product_details.dart';
//import 'package:frontend/features/inventory/listview/inventory_list.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/themes/config.dart';
import 'core/themes/xpos_theme.dart';
import 'datasources/authentication/authentication_datasource.dart';
import 'datasources/authentication/authentication_remote_datasource.dart';
import 'features/authentication/screens/authentication_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'providers/user_provider.dart';
import 'repositories/authentication/authentication_repository.dart';
import 'repositories/authentication/authentication_repository_implementation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //  await Firebase.initializeApp();

  HttpLink _httpLink;
  GraphQLClient _client;
  IAuthenticationDataSource _authenticationDataSource;
  IAuthenticationRepository _authenticationRepository;
  SharedPreferences _storage;

  final uri =
      kReleaseMode ? 'WHEN_SERVER_IS_HOSTED' : 'http://iterators-pos.herokuapp.com/graphql';

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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        Provider<AuthenticationRepository>(
          create: (context) => _authenticationRepository,
        )
      ],
      builder: (context, child) {
        Provider.of<AuthenticationRepository>(context, listen: false)
            .getUser()
            .then(
          (value) {
            var data = value.fold((e) => null, (token) => token);

            value.isRight && data != null
                ? Provider.of<UserProvider>(context, listen: false).token =
                    data.toString()
                : null;
          },
        );

        return MyApp();
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: XPosTheme.lightTheme,
      darkTheme: XPosTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      home: Consumer<UserProvider>(
        builder: (context, user, child) {
          return user.token != null ? HomeScreen() : AuthenticationScreen();
        },
      ),
    );
  }
}
