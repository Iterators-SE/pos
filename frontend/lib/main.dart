import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/themes/config.dart';
import 'core/themes/xpos_theme.dart';
import 'datasources/authentication/authentication_datasource.dart';
import 'datasources/authentication/authentication_remote_datasource.dart';
import 'datasources/discount/discount_remote_datasource.dart';
import 'datasources/transactions/transaction_datasource.dart';
import 'datasources/transactions/transaction_local_datasource.dart';
import 'datasources/transactions/transaction_remote_datasource.dart';
import 'features/authentication/screens/authentication_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'providers/user_provider.dart';
import 'repositories/authentication/authentication_repository.dart';
import 'repositories/authentication/authentication_repository_implementation.dart';
import 'repositories/discount/discount_repository.dart';
import 'repositories/discount/discount_repository_implementation.dart';
import 'repositories/transactions/transaction_repository.dart';
import 'repositories/transactions/transaction_repository_implementation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //  await Firebase.initializeApp();

  HttpLink _httpLink;
  GraphQLClient _client;
  NetworkInfo _networkInfo;

  IAuthenticationDataSource _authenticationDataSource;
  IAuthenticationRepository _authenticationRepository;

  IDiscountRepository _discountRepository;

  ITransactionRemoteDataSource _transactionRemoteDataSource;
  ITransactionLocalDataSource _transactionLocalDataSource;
  ITransactionRepository _transactionRepository;

  SharedPreferences _storage;

  final devUri = 'http://localhost:5000/graphql';
  final prodUri = 'http://iterators-pos.herokuapp.com/graphql';
  final uri = kReleaseMode ? prodUri : devUri;

  _httpLink = HttpLink(uri);
  _client = GraphQLClient(
    cache: GraphQLCache(),
    link: _httpLink,
  );

  _networkInfo = NetworkInfoImplementation();

  _authenticationDataSource = AuthenticationRemoteDataSource(
    client: _client,
    storage: _storage,
  );

  _authenticationRepository = AuthenticationRepository(
    remote: _authenticationDataSource,
  );

  _transactionLocalDataSource = TransactionLocalDataSource();
  _transactionRemoteDataSource = TransactionRemoteDataSource(client: _client);

  _transactionRepository = TransactionRepository(
    remote: _transactionRemoteDataSource,
    local: _transactionLocalDataSource,
    network: _networkInfo,
  );

  _discountRepository = DiscountRepository(
    remote: DiscountRemoteDataSource(
      client: _client,
      storage: _storage,
    ),
    network: _networkInfo
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        Provider<AuthenticationRepository>(
          create: (context) => _authenticationRepository,
        ),
        Provider<TransactionRepository>(
          create: (context) => _transactionRepository,
        ),
        Provider<DiscountRepository>(
          create: (context) => _discountRepository,
        )
      ],
      builder: (context, child) {
        Provider.of<AuthenticationRepository>(context, listen: false)
            .getUser()
            .then(
          (value) {
            var data = value.fold((e) => null, (token) => token);

            if (value.isRight && data != null) {
              Provider.of<UserProvider>(context, listen: false).token =
                  data.toString();

              _client = GraphQLClient(
                cache: GraphQLCache(),
                link: AuthLink(getToken: () => 'Bearer ${data.toString()}')
                    .concat(_httpLink),
              );
            } else {
              Provider.of<UserProvider>(context, listen: false).token = null;
              _client = GraphQLClient(
                cache: GraphQLCache(),
                link: _httpLink,
              );
            }
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
