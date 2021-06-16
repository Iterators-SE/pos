import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/error/failure.dart';
import 'package:frontend/features/discount/screen/discount_screen.dart';
import 'package:frontend/models/discounts.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/product_variant.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/repositories/discount/discount_repository_implementation.dart';
import 'package:frontend/repositories/inventory/inventory_repository_implementation.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockInventoryRepository extends Mock implements InventoryRepository {
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      var data = [
        Product(id: 2, name: "Poseidon", variants: [
          ProductVariant(
            variantId: 1,
            price: 100,
            quantity: 300,
            variantName: "Small",
            productId: 2,
          ),
          ProductVariant(
            variantId: 2,
            price: 120,
            quantity: 40,
            variantName: "Regular",
            productId: 2,
          ),
          ProductVariant(
            variantId: 3,
            price: 180,
            quantity: 3,
            variantName: "Large",
            productId: 2,
          ),
        ]),
        Product(id: 1, name: "Olympus Cappucino", variants: [
          ProductVariant(
            variantId: 4,
            price: 100,
            quantity: 300,
            variantName: "Small",
            productId: 1,
          ),
          ProductVariant(
            variantId: 5,
            price: 120,
            quantity: 40,
            variantName: "Regular",
            productId: 1,
          ),
          ProductVariant(
            variantId: 6,
            price: 180,
            quantity: 3,
            variantName: "Large",
            productId: 1,
          ),
        ]),
      ];

      return Right(data);
    } catch (e) {
      return Left(e);
    }
  }
}

class MockDiscountRepository extends Mock implements DiscountRepository {
  Future<Either<Failure, List<Discount>>> getDiscounts() async {
    try {
      var data = [
        Discount(
          id: 1,
          percentage: 20,
          products: [1, 2],
          description: "Senior Citizen",
        ),
        Discount(
          id: 2,
          percentage: 15,
          products: [1, 2],
          description: "PWD",
        )
      ];
      return Right(data);
    } catch (e) {
      return Left(e);
    }
  }
}

void main() {
  testWidgets('Discounts: Shows discounts', (tester) async {
    final _inventoryRepository = MockInventoryRepository();
    final _discountRepository = MockDiscountRepository();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<InventoryRepository>(
            create: (context) => _inventoryRepository,
          ),
          Provider<DiscountRepository>(
            create: (context) => _discountRepository,
          ),
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
          ),
        ],
        builder: (context, child) {
          return MaterialApp(home: DiscountScreen());
        },
      ),
    );

    final senior = find.text('Senior Citizen');
    final pwd = find.text('PWD');

    await tester.pumpAndSettle();

    expect(senior, findsOneWidget);
    expect(pwd, findsOneWidget);
  });
}
