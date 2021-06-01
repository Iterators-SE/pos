import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/error/failure.dart';
import 'package:frontend/core/ui/styled_text_button.dart';
import 'package:frontend/features/orders/screens/order_screen.dart';
import 'package:frontend/features/orders/screens/widget/custom_data_table.dart';
import 'package:frontend/models/discounts.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/product_variant.dart';
import 'package:frontend/models/tax.dart';
import 'package:frontend/repositories/discount/discount_repository_implementation.dart';
import 'package:frontend/repositories/inventory/inventory_repository_implementation.dart';
import 'package:frontend/repositories/tax/tax_repository_implementation.dart';
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

class MockTaxRepository extends Mock implements TaxRepository {
  Future<Either<Failure, Tax>> getSelectedTax() async {
    try {
      final data = Tax(id: 5, isSelected: true, name: "VAT", percentage: 0.12);
      return Right(data);
    } catch (e) {
      return Left(e);
    }
  }
}

void main() {
  testWidgets('Orders: Shows correct message when first opened',
      (tester) async {
    final _inventoryRepository = MockInventoryRepository();
    final _discountRepository = MockDiscountRepository();
    final _taxRepository = MockTaxRepository();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<InventoryRepository>(
            create: (context) => _inventoryRepository,
          ),
          Provider<DiscountRepository>(
            create: (context) => _discountRepository,
          ),
          Provider<TaxRepository>(
            create: (context) => _taxRepository,
          )
        ],
        builder: (context, child) {
          return MaterialApp(home: OrderScreen());
        },
      ),
    );

    await tester.pump(Duration(seconds: 5));

    final textFinder = find.text('Looks a little empty...');
    final buttonFinder = find.widgetWithText(StyledTextButton, 'Add an Order');

    expect(textFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);
  });

  testWidgets('Orders: Updates UI when order is added', (tester) async {
    final _inventoryRepository = MockInventoryRepository();
    final _discountRepository = MockDiscountRepository();
    final _taxRepository = MockTaxRepository();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<InventoryRepository>(
            create: (context) => _inventoryRepository,
          ),
          Provider<DiscountRepository>(
            create: (context) => _discountRepository,
          ),
          Provider<TaxRepository>(
            create: (context) => _taxRepository,
          )
        ],
        builder: (context, child) {
          return MaterialApp(home: OrderScreen());
        },
      ),
    );

    await tester.pumpAndSettle();

    final button = find.widgetWithText(StyledTextButton, 'Add an Order');

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    final productField = find.byKey(Key('product_field'));
    final variantField = find.byKey(Key('variant_field'));
    final quantityField = find.byKey(Key('quantity_field'));

    final product = find.byKey(Key('Poseidon'));
    final variant = find.byKey(Key('Large'));

    final addOrderButton = find.widgetWithText(
      FloatingActionButton,
      'Add Product',
    );
    final customDataTable = find.byWidgetPredicate(
      (widget) => widget is CustomDataTable,
    );

    expect(productField, findsOneWidget);
    expect(variantField, findsOneWidget);
    expect(quantityField, findsOneWidget);

    await tester.tap(productField);
    await tester.pump();

    expect(product, findsNWidgets(2));

    await tester.tap(product.first);
    await tester.pump();

    await tester.tap(variantField);
    await tester.pump();

    expect(variant, findsNWidgets(2));

    await tester.tap(variant.first);
    await tester.pump();

    await tester.enterText(quantityField, '4');

    await tester.pump();

    expect(customDataTable, findsNothing); // Does not navigate onError

    await tester.showKeyboard(quantityField);
    await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
    await tester.enterText(quantityField, '3');
    await tester.tap(addOrderButton);

    await tester.pump();

    expect(customDataTable, findsNWidgets(2));
  });
}
