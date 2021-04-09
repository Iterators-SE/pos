// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/error/failure.dart';
import 'package:frontend/datasources/authentication/authentication_datasource.dart';
import 'package:frontend/datasources/authentication/authentication_remote_datasource.dart';
import 'package:frontend/features/authentication/screens/authentication_screen.dart';
import 'package:frontend/features/home/screens/home_screen.dart';
import 'package:frontend/features/home/screens/widget/menu_item_card.dart';
import 'package:frontend/main.dart';

import 'package:frontend/models/user.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/repositories/authentication/authentication_repository_implementation.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';

import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {
  GraphQLClient client;
  SharedPreferences storage;

  MockAuthenticationRemoteDataSource();
  String _token;

  Future<User> login({String email, String password}) async {
    _token =
        '''eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJjb25maXJtZWQiOnRydWV9.ZzDhdYJg_FzeVenSWLBsNkDbH9RP40z708Ttgqw_7JU''';
    return User(token: _token);
  }

  Future<dynamic> getUser() async {
    return _token;
  }
}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {
  IAuthenticationDataSource remote;

  MockAuthenticationRepository({this.remote});

  Future<Either<Failure, User>> login({String email, String password}) async {
    try {
      var data = await remote.login(email: email, password: password);
      return Right(data);
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<Failure, dynamic>> getUser() async {
    try {
      var data = await remote.getUser();
      return Right(data);
    } catch (e) {
      return Left(e);
    }
  }
}

void main() {
  testWidgets('Authentication: Login smoke test', (tester) async {
    final _authenticationRemote = MockAuthenticationRemoteDataSource();
    final _authenticationRepository = MockAuthenticationRepository(
      remote: _authenticationRemote,
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
          ),
          Provider<AuthenticationRepository>(
            create: (context) => _authenticationRepository,
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
