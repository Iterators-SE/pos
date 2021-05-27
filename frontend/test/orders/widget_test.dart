import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/ui/styled_text_button.dart';
import 'package:frontend/features/orders/screens/order_screen.dart';


void main() {
  testWidgets('Orders: Shows correct message when first opened',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: OrderScreen(),
    ));

    final textFinder = find.text('Looks a little empty...');
    final buttonFinder = find.widgetWithText(StyledTextButton, 'Add an Order');


    expect(textFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);
  });
}
