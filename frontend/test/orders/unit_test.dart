import 'package:frontend/features/orders/models/order.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/product_variant.dart';
import 'package:test/test.dart';

void main() {
  group('Order Widgets', () {
    test('Order Model should be able to add products', () {
      var allProducts = [
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

      var order = Order();

      order.addProduct(
        allProducts[0].variants[0].copyWith(quantity: 5),
      );

      order.addProduct(
        allProducts[1].variants[0].copyWith(quantity: 10),
      );

      order.addProduct(
        allProducts[1].variants[2].copyWith(quantity: 3),
      );

      order.addProduct(
        allProducts[0].variants[2].copyWith(quantity: 3),
      );

      expect(order.products.length, 4);
    });

    test('Order Model should be able to edit products', () {
      var allProducts = [
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

      var order = Order();

      order.addProduct(
        allProducts[0].variants[0].copyWith(quantity: 5),
      );

      order.addProduct(
        allProducts[1].variants[0].copyWith(quantity: 10),
      );

      order.addProduct(
        allProducts[1].variants[2].copyWith(quantity: 3),
      );

      order.addProduct(
        allProducts[0].variants[2].copyWith(quantity: 3),
      );

      expect(order.products.length, 4);

      order.editProduct(allProducts[0].variants[2].copyWith(quantity: 10));
      order.addProduct(allProducts[0].variants[0].copyWith(quantity: 5));

      expect(order.products.length, 4);
    });

    test('Order Model should calculate correct total', () {
      var allProducts = [
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

      var order = Order();

      order.addProduct(
        allProducts[0].variants[0].copyWith(quantity: 5),
      );

      order.addProduct(
        allProducts[1].variants[0].copyWith(quantity: 10),
      );

      order.addProduct(
        allProducts[1].variants[2].copyWith(quantity: 3),
      );

      order.addProduct(
        allProducts[0].variants[2].copyWith(quantity: 3),
      );

      expect(order.products.length, 4);
      expect(order.total, 180 * 6 + 1500);
    });
  });
}
