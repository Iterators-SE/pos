import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/error/failure.dart';
import 'package:frontend/features/inventory/models/new_product.dart';
import 'package:frontend/features/inventory/screens/inventory_list_screen.dart';
import 'package:frontend/features/inventory/screens/product_details_screen.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/product_variant.dart';
import 'package:frontend/repositories/inventory/inventory_repository_implementation.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:image_test_utils/image_test_utils.dart';

class MockInventoryRepository extends Mock implements InventoryRepository {
  Future<Either<Failure, bool>> addProduct({NewProduct product}) async {
    try {
      return Right(true);
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      return Right([]);
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<Failure, bool>> deleteProduct({int productId}) async {
    if (true) {
      try {
        return Right(true);
      } catch (e) {
        return Left(e);
      }
    }
    // return Left(UnhandledFailure());
  }
}

void main() {
  testWidgets('Inventory: Should show empty inventory message', (tester) async {
    final _inventoryRepository = MockInventoryRepository();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<InventoryRepository>(
            create: (context) => _inventoryRepository,
          ),
        ],
        builder: (context, child) {
          return MaterialApp(home: InventoryListScreen());
        },
      ),
    );

    await tester.pump(Duration(seconds: 5));

    final textFinder = find.text("Your inventory is empty.");

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Inventory: Should show the correct message on product delete.',
      (tester) async {
    provideMockedNetworkImages(() async {
      final _inventoryRepository = MockInventoryRepository();
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider<InventoryRepository>(
              create: (context) => _inventoryRepository,
            ),
          ],
          builder: (context, child) {
            return MaterialApp(
                home: ProductDetailScreen(
              product: Product(
                  id: 2,
                  name: "Milky Tea",
                  description: "The best milky tea ever!",
                  discount: 0,
                  isTaxable: true,
                  photoLink:
                      "",
                  variants: [
                    ProductVariant(
                      variantId: 1,
                      price: 50,
                      quantity: 300,
                      variantName: "Small",
                      productId: 2,
                    ),
                    ProductVariant(
                      variantId: 2,
                      price: 70,
                      quantity: 40,
                      variantName: "Regular",
                      productId: 2,
                    ),
                    ProductVariant(
                      variantId: 3,
                      price: 90,
                      quantity: 3,
                      variantName: "Large",
                      productId: 2,
                    ),
                  ]),
            ));
          },
        ),
      );

      await tester.pump(Duration(seconds: 5));

      final button =
          find.widgetWithIcon(IconButton, Icons.delete_forever_outlined);

      await tester.tap(button);
      await tester.pumpAndSettle();

      final textFinder = find.text("Product has been deleted.");

      expect(textFinder, findsOneWidget);
    });
  });

  
}
