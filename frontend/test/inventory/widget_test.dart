import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/error/failure.dart';
import 'package:frontend/features/inventory/screens/add_product_screen.dart';
import 'package:frontend/features/inventory/screens/edit_details_screen.dart';
import 'package:frontend/features/inventory/screens/inventory_list_screen.dart';
import 'package:frontend/features/inventory/screens/product_details_screen.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/product_variant.dart';
import 'package:frontend/repositories/inventory/inventory_repository_implementation.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';

class MockInventoryRepository extends Mock implements InventoryRepository {
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      var data = [
        Product(
            id: 2,
            name: "Cake",
            description: "The best cake ever!",
            photoLink:
                "https://beyondfrosting.com/wp-content/uploads/2019/01/Chocolate-Cake-Recipe-017.jpg",
            isTaxable: true,
            variants: [
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
        Product(
            id: 1,
            name: "Milk Tea",
            description: "Very addictive!",
            photoLink:
                "https://beyondfrosting.com/wp-content/uploads/2019/01/Chocolate-Cake-Recipe-017.jpg",
            isTaxable: true,
            variants: [
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

  Future<Either<Failure, bool>> deleteProduct({int productId}) async {
    try {
      return Right(true);
    } catch (e) {
      return Left(e);
    }
  }
}

void main() {
  testWidgets("Inventory List: Shows all products.", (tester) async {
    await mockNetworkImagesFor(() async {
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
      final button = find.widgetWithIcon(FloatingActionButton, Icons.add);
      final tiles = find.byKey(Key("productListTile"));

      expect(button, findsOneWidget);
      expect(tiles, findsNWidgets(2));
    });
  });

  testWidgets("Product details must show the right info.", (tester) async {
    await mockNetworkImagesFor(() async {
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
                name: "Cake",
                description: "The best cake ever!",
                photoLink:
                    "https://beyondfrosting.com/wp-content/uploads/2019/01/Chocolate-Cake-Recipe-017.jpg",
                isTaxable: true,
                variants: [
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
                ],
              ),
            ));
          },
        ),
      );

      await tester.pump(Duration(seconds: 5));
      final nameField = find.widgetWithText(TextFormField, "Cake");
      final descriptionField = find.widgetWithText(TextFormField, "Cake");
      final variantBox = find.byKey(Key("variantBox"));

      final variantName1 = find.widgetWithText(TextFormField, "Regular");
      final variantName2 = find.widgetWithText(TextFormField, "Large");

      final variantQuantity1 = find.widgetWithText(TextFormField, "40");
      final variantQuantity2 = find.widgetWithText(TextFormField, "3");

      final variantPrice1 = find.widgetWithText(TextFormField, "120");
      final variantPrice2 = find.widgetWithText(TextFormField, "180");

      expect(nameField, findsOneWidget);
      expect(descriptionField, findsOneWidget);
      expect(variantBox, findsNWidgets(2));

      expect(variantName1, findsOneWidget);
      expect(variantName2, findsOneWidget);

      expect(variantQuantity1, findsOneWidget);
      expect(variantQuantity2, findsOneWidget);

      expect(variantPrice1, findsOneWidget);
      expect(variantPrice2, findsOneWidget);
    });
  });

  testWidgets("Product must be deleted successfully", (tester) async {
    await mockNetworkImagesFor(() async {
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
                name: "Cake",
                description: "The best cake ever!",
                photoLink:
                    "https://beyondfrosting.com/wp-content/uploads/2019/01/Chocolate-Cake-Recipe-017.jpg",
                isTaxable: true,
                variants: [
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
                ],
              ),
            ));
          },
        ),
      );

      final deleteButton =
          find.widgetWithIcon(IconButton, Icons.delete_forever_outlined);

      final editButton = find.widgetWithIcon(IconButton, Icons.edit);

      expect(deleteButton, findsOneWidget);
      expect(editButton, findsOneWidget);

      await tester.tap(deleteButton);
      await tester.pumpAndSettle();

      final dialogBox = find.widgetWithText(AlertDialog, "Delete");
      final dialogBoxMessage =
          find.text("Are you sure you want to delete this product?");

      final yesButton = find.widgetWithText(TextButton, "Yes");
      final noButton = find.widgetWithText(TextButton, "No");

      expect(dialogBox, findsOneWidget);
      expect(dialogBoxMessage, findsOneWidget);
      expect(yesButton, findsOneWidget);
      expect(noButton, findsOneWidget);

      await tester.tap(noButton);
      await tester.pumpAndSettle();

      expect(dialogBox, findsNothing);

      await tester.tap(deleteButton);
      await tester.pumpAndSettle();

      await tester.tap(yesButton);
      await tester.pumpAndSettle();

      final deleteMessage = find.text("Product has been deleted.");
      final okayButton = find.widgetWithText(ElevatedButton, "Okay");
      // expect(deleteMessage, findsOneWidget);
      expect(okayButton, findsOneWidget);
    });
  });

  testWidgets("Add product screen must have all widgets", (tester) async {
    final _inventoryRepository = MockInventoryRepository();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<InventoryRepository>(
            create: (context) => _inventoryRepository,
          ),
        ],
        builder: (context, child) {
          return MaterialApp(home: AddProductScreen());
        },
      ),
    );

    await tester.pumpAndSettle();

    final selectImageButton =
        find.widgetWithText(ElevatedButton, "Select an image");
    final imageMessage = find.text("You have not yet picked an image.");
    final nameField = find.byKey(Key("productName"));
    final descriptionField = find.byKey(Key("productDescription"));

    expect(selectImageButton, findsOneWidget);
    expect(imageMessage, findsOneWidget);
    expect(nameField, findsOneWidget);
    expect(descriptionField, findsOneWidget);

    final addVariantButton = find.widgetWithText(ElevatedButton, "Add");
    final addVariantDialog = find.byKey(Key("variantDialog"));

    expect(addVariantButton, findsOneWidget);

    await tester.tap(addVariantButton);
    await tester.pumpAndSettle();

    expect(addVariantDialog, findsOneWidget);

    final varNameField = find.byKey(Key("variantName"));
    final varQuantityField = find.byKey(Key("variantQuantity"));
    final varPriceField = find.byKey(Key("variantPrice"));
    final confirmButton = find.widgetWithText(ElevatedButton, "Confirm");

    expect(varNameField, findsOneWidget);
    expect(varQuantityField, findsOneWidget);
    expect(varPriceField, findsOneWidget);

    await tester.enterText(varNameField, 'Regular');
    await tester.enterText(varQuantityField, '10');
    await tester.enterText(varPriceField, '100');
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final variantBox = find.byKey(Key("variantBox"));

    expect(variantBox, findsNWidgets(1));
    expect(addVariantDialog, findsNothing);
  });

  testWidgets("Edit product screen must show the right data and widgets",
      (tester) async {
    await mockNetworkImagesFor(() async {
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
              home: EditDetailScreen(
                product: Product(
                  id: 2,
                  name: "Cake",
                  description: "The best cake ever!",
                  photoLink:
                      "https://beyondfrosting.com/wp-content/uploads/2019/01/Chocolate-Cake-Recipe-017.jpg",
                  isTaxable: true,
                  variants: [
                    ProductVariant(
                      variantId: 2,
                      price: 120,
                      quantity: 40,
                      variantName: "Regular",
                      productId: 2,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      final changeImageButton =
          find.widgetWithText(ElevatedButton, "Change Image");

      final addVariantButton = find.widgetWithText(ElevatedButton, "Add");

      final nameField = find.widgetWithText(TextFormField, "Cake");
      final descriptionField =
          find.widgetWithText(TextFormField, "The best cake ever!");

      final varNameField = find.widgetWithText(TextFormField, "Regular");
      final varQuantityField = find.widgetWithText(TextFormField, "40");
      final varPriceField = find.widgetWithText(TextFormField, "120");

      expect(changeImageButton, findsOneWidget);
      expect(addVariantButton, findsOneWidget);
      expect(nameField, findsOneWidget);
      expect(descriptionField, findsOneWidget);
      expect(varNameField, findsOneWidget);
      expect(varQuantityField, findsOneWidget);
      expect(varPriceField, findsOneWidget);

      // await tester.tap(addVariantButton);
      // await tester.pumpAndSettle();

      // final addVariantDialog = find.byKey(Key("addVariant"));
      // expect(addVariantDialog, findsOneWidget);
    });
  });
}
