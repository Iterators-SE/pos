// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/datasources/authentication/authentication_datasource.dart';
import 'package:frontend/datasources/authentication/authentication_remote_datasource.dart';

import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/authentication/authentication_repository_implementation.dart';
import 'package:frontend/views/auth/login_page.dart';
import 'package:frontend/views/home/home_page.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';

import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {
  GraphQLClient client;
  SharedPreferences storage;

  MockAuthenticationRemoteDataSource();

  Future<User> login({String email, String password}) async {
    return User(
        token:
            '''eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJjb25maXJtZWQiOnRydWV9.ZzDhdYJg_FzeVenSWLBsNkDbH9RP40z708Ttgqw_7JU''');
  }
}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {
  IAuthenticationDataSource remote;

  MockAuthenticationRepository({this.remote});
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('Authentication: Login smoke test', (tester) async {
    final _authenticationRemote = MockAuthenticationRemoteDataSource();
    final _authenticationRepository = MockAuthenticationRepository(
      remote: _authenticationRemote,
    );

    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<AuthenticationRemoteDataSource>(
            create: (context) => _authenticationRemote,
          ),
          Provider<AuthenticationRepository>(
            create: (context) => _authenticationRepository,
          ),
        ],
        child: MaterialApp(
          home: LoginPage(),
          navigatorObservers: [mockObserver],
        ),
      ),
    );

    final email = find.widgetWithText(TextFormField, 'Email');
    final password = find.widgetWithText(TextFormField, 'Password');
    final button = find.widgetWithText(MaterialButton, 'Login');

    // Verify that our page has email and password fields
    expect(find.text('Login'), findsNWidgets(2));
    expect(find.widgetWithText(TextFormField, 'Name'), findsNothing);
    expect(email, findsOneWidget);
    expect(password, findsOneWidget);

    // [TODO: When assigned teammate fixes UX]
    // Input an invalid email to show validation text
    // await tester.enterText(email, '123');
    // expect(find.text('Email Is Invalid'), findsOneWidget);

    // Input email and password
    await tester.enterText(email, 'johndoe@example.com');
    await tester.enterText(password, 'johndoe123');
    await tester.tap(button);

    await tester.pumpAndSettle();

    // Navigates to Home Page on button tap
    verify(mockObserver.didPush(any, any));
    expect(email, findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });
}
