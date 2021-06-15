import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/error/failure.dart';
import 'package:frontend/features/profile/screens/page/profile_page.dart';
import 'package:frontend/models/user_profile.dart';
import 'package:frontend/repositories/profile/profile_repository_implementation.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockProfileRepository extends Mock implements ProfileRepository {
  Future<Either<Failure, UserProfile>> getProfileInfo() async {
    try {
      return Right(UserProfile(
          name: "Alanray Store",
          address: "Villa, Arevalo",
          email: "ealanray@gmail.com",
          id: 1,
          receiptMessage: "Thank you!"));
    } catch (e) {
      return Left(e);
    }
  }
}

void main() {
  testWidgets("Profile should show all profile data", (tester) async {
    final _profileRepository = MockProfileRepository();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<ProfileRepository>(
            create: (context) => _profileRepository,
          ),
        ],
        builder: (context, child) {
          return MaterialApp(home: ProfilePage());
        },
      ),
    );

    await tester.pumpAndSettle();
    final nameField = find.widgetWithText(TextFormField, "Alanray Store");
    final emailField = find.widgetWithText(TextFormField, "ealanray@gmail.com");
    final addressField = find.widgetWithText(TextFormField, "Villa, Arevalo");
    final messageField = find.widgetWithText(TextFormField, "Thank you!");

    expect(nameField, findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(addressField, findsOneWidget);
    expect(messageField, findsOneWidget);
  });
}
