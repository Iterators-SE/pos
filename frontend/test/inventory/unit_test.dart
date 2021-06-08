import 'package:frontend/features/inventory/models/new_product.dart';
import 'package:frontend/features/inventory/models/new_variant.dart';
import 'package:test/test.dart';

void main() {
  group('Inventory Models', () {
    test('NewProduct Model should be able to add or delete NewVariant objects',
        () {
      var newProduct = NewProduct(
        description: "The best milk tea in town!",
        isTaxable: false,
        name: "The best milk tea!",
        photoLink: "http://insertImageLinkHere.jpeg",
      );

      newProduct
          .addVariant(NewVariant(name: "Regular", price: 100, quantity: 25));

      newProduct
          .addVariant(NewVariant(name: "Large", price: 125, quantity: 25));

      newProduct
          .addVariant(NewVariant(name: "Oops wrong", price: 0, quantity: 0));

      
      expect(newProduct.variants.length, 3);
      
      newProduct.deleteVariant();

      expect(newProduct.variants.length, 2);

    });
  });
}
