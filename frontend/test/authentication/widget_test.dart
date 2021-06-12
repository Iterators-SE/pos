import 'package:either_option/either_option.dart';
import 'package:frontend/datasources/discount/discount_remote_datasource.dart';
import 'package:frontend/datasources/inventory/inventory_remote_datasource.dart';
import 'package:frontend/datasources/profile/profile_remote_datasource.dart';
import 'package:frontend/datasources/tax/tax_remote_datasource.dart';
import 'package:frontend/datasources/transactions/transaction_remote_datasource.dart';
import 'package:frontend/repositories/discount/discount_repository_implementation.dart';
import 'package:frontend/repositories/profile/profile_repository_implementation.dart';
import 'package:frontend/repositories/tax/tax_repository_implementation.dart';
import 'package:frontend/repositories/transactions/transaction_repository_implementation.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/core/error/failure.dart';
import 'package:frontend/features/home/screens/home_screen.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/repositories/authentication/authentication_repository_implementation.dart';
import 'package:frontend/repositories/inventory/inventory_repository_implementation.dart';

import 'package:mockito/mockito.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {
  var _token;

  Future<Either<Failure, User>> login({String email, String password}) async {
    try {
      _token =
          '''eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJjb25maXJtZWQiOnRydWV9.ZzDhdYJg_FzeVenSWLBsNkDbH9RP40z708Ttgqw_7JU''';
      return Right(User(token: _token));
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<Failure, dynamic>> getUser() async {
    try {
      return Right(_token);
    } catch (e) {
      return Left(e);
    }
  }
}

class MockTransactionRepository extends Mock implements TransactionRepository {
  TransactionRemoteDataSource remote = TransactionRemoteDataSource(
    client: GraphQLClient(link: HttpLink("fakeLink.com"), cache: GraphQLCache())
  );
}

class MockInventoryRepository extends Mock implements InventoryRepository {
    InventoryRemoteDataSource remote = InventoryRemoteDataSource(
    client: GraphQLClient(
      link: HttpLink("fakeLink.com"), 
      cache: GraphQLCache(),
    ),
  );
}

class MockDiscountRepository extends Mock implements DiscountRepository {
    DiscountRemoteDataSource remote = DiscountRemoteDataSource(
    client: GraphQLClient(
      link: HttpLink("fakeLink.com"), 
      cache: GraphQLCache(),
    ), local: null, storage: null,
  );
}

class MockProfileRepository extends Mock implements ProfileRepository {
  ProfileRemoteDatasource remote = ProfileRemoteDatasource(
    client: GraphQLClient(
      link: HttpLink("fakeLink.com"), 
      cache: GraphQLCache(),
    ),
  );
}

class MockTaxRepository extends Mock implements TaxRepository {
    TaxRemoteDataSource remote = TaxRemoteDataSource(
    client: GraphQLClient(
      link: HttpLink("fakeLink.com"), 
      cache: GraphQLCache(),
    ),
  );
}

void main() {
  testWidgets('Authentication: Login smoke test', (tester) async {

    final _authenticationRepository = MockAuthenticationRepository();
    final _inventoryRepository = MockInventoryRepository();
    final _transactionRepository = MockTransactionRepository();
    final _discountRepository = MockDiscountRepository();
    final _profileRepository = MockProfileRepository();
    final _taxRepository = MockTaxRepository();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
          ),
          Provider<AuthenticationRepository>(
            create: (context) => _authenticationRepository,
          ),
          Provider<InventoryRepository>(
            create: (context) => _inventoryRepository,
          ),
          Provider<TransactionRepository>(
            create: (context) => _transactionRepository,
          ),
          Provider<DiscountRepository>(
            create: (context) => _discountRepository,
          ),
          Provider<ProfileRepository>(
            create: (context) => _profileRepository,
          ),
          Provider<TaxRepository>(
            create: (context) => _taxRepository,
          ),
        ],
        builder: (context, child) {
          return MyApp();
        },
      ),
    );

    final email = find.byKey(Key('email'));
    final password = find.byKey(Key('password'));
    final name = find.byKey(Key('name'));
    final button = find.widgetWithText(MaterialButton, 'Login');

    expect(name, findsNothing);
    expect(email, findsOneWidget);
    expect(password, findsOneWidget);
    expect(button, findsOneWidget);

    await tester.enterText(email, '123');
    await tester.pumpAndSettle();
    expect(find.text('Email is invalid'), findsOneWidget);

    await tester.enterText(email, 'johndoe@example.com');
    await tester.enterText(password, 'johndoe123');
    await tester.tap(button);

    await tester.pumpAndSettle();

    expect(email, findsNothing);
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
