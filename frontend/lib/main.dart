import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/datasources/profile/profile_datasource.dart';
import 'package:frontend/datasources/profile/profile_local_datasource.dart';
import 'package:frontend/datasources/profile/profile_remote_datasource.dart';
import 'package:frontend/repositories/profile/profile_repository.dart';
import 'package:frontend/repositories/profile/profile_repository_implementation.dart';
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
import 'datasources/inventory/inventory_datasource.dart';
import 'datasources/inventory/inventory_local_datasource.dart';
import 'datasources/inventory/inventory_remote_datasource.dart';
import 'datasources/transactions/transaction_datasource.dart';
import 'datasources/transactions/transaction_local_datasource.dart';
import 'datasources/transactions/transaction_remote_datasource.dart';

import 'features/authentication/screens/authentication_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'graphql/queries.dart';

import 'providers/user_provider.dart';

import 'repositories/authentication/authentication_repository.dart';
import 'repositories/authentication/authentication_repository_implementation.dart';
import 'repositories/discount/discount_repository.dart';
import 'repositories/discount/discount_repository_implementation.dart';
import 'repositories/inventory/inventory_repository.dart';
import 'repositories/inventory/inventory_repository_implementation.dart';
import 'repositories/transactions/transaction_repository.dart';
import 'repositories/transactions/transaction_repository_implementation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  HttpLink _httpLink;
  GraphQLClient _client;
  NetworkInfo _networkInfo;

  IAuthenticationDataSource _authenticationDataSource;
  IAuthenticationRepository _authenticationRepository;

  IDiscountRepository _discountRepository;

  ITransactionRemoteDataSource _transactionRemoteDataSource;
  ITransactionLocalDataSource _transactionLocalDataSource;
  ITransactionRepository _transactionRepository;

  IInventoryRemoteDataSource _inventoryRemoteDataSource;
  IInventoryLocalDataSource _inventoryLocalDataSource;
  IInventoryRepository _inventoryRepository;

  IProfileRemoteDataSource _profileRemoteDataSource;
  ProfileLocalDataSource _profileLocalDataSource;
  IProfileRepository _profileRepository;

  SharedPreferences _storage;

  final devUri = 'http://localhost:5000/graphql';
  final prodUri = 'http://iterators-pos.herokuapp.com/graphql';
  final uri = kReleaseMode ? prodUri : devUri;

  _httpLink = HttpLink(uri);

  _client = GraphQLClient(
    cache: GraphQLCache(),
    link: _httpLink,
  );

  // _client = GraphQLClient(
  //   cache: GraphQLCache(),
  //   link: AuthLink(
  //           getToken: () =>
  //               'Bearer ')
  //       .concat(_httpLink),
  // );

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
      network: _networkInfo);

  _inventoryLocalDataSource = InventoryLocalDataSource();
  _inventoryRemoteDataSource = InventoryRemoteDataSource(
    client: _client,
    queries: MutationQuery(),
  );

  _inventoryRepository = InventoryRepository(
    remote: _inventoryRemoteDataSource,
    local: _inventoryLocalDataSource,
    network: _networkInfo,
  );

  _profileLocalDataSource = ProfileLocalDataSource();
  _profileRemoteDataSource = ProfileRemoteDatasource(
    client: _client,
  );

  _profileRepository = ProfileRepository(
      remote: _profileRemoteDataSource,
      local: _profileLocalDataSource,
      network: _networkInfo);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        Provider<ProfileRepository>(
          create: (context) => _profileRepository,
        ),
        Provider<AuthenticationRepository>(
          create: (context) => _authenticationRepository,
        ),
        Provider<TransactionRepository>(
          create: (context) => _transactionRepository,
        ),
        Provider<DiscountRepository>(
          create: (context) => _discountRepository,
        ),
        Provider<InventoryRepository>(
          create: (context) => _inventoryRepository,
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
