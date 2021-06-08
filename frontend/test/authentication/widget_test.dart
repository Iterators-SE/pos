import 'package:either_option/either_option.dart';
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

class MockInventoryRepository extends Mock implements InventoryRepository {}

void main() {
  testWidgets('Authentication: Login smoke test', (tester) async {
    final _authenticationRepository = MockAuthenticationRepository();
    final _inventoryRepository = MockInventoryRepository();

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
