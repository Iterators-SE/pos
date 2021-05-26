import 'dart:convert';

import 'package:graphql/client.dart';

import '../../features/inventory/models/new_product.dart';
import '../../features/inventory/models/new_variant.dart';
import '../../graphql/queries.dart';
import '../../models/product.dart';
import '../../models/product_variant.dart';
import 'inventory_datasource.dart';

class InventoryRemoteDataSource implements IInventoryRemoteDataSource {
  InventoryRemoteDataSource({this.client, this.queries});

  final GraphQLClient client;
  final MutationQuery queries;

  @override
  Future<Product> addProduct({NewProduct product}) async {
    try {
      final response = await client.query(
        QueryOptions(
          document: gql(
            queries.addProducts(product.name, product.description,
                product.isTaxable, product.photoLink),
          ),
        ),
      );
      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['addProduct']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteProduct({int productId}) async {
    try {
      final response = await client.query(
        QueryOptions(
          document: gql(queries.deleteProduct(productId)),
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['deleteProduct']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Product> getProductDetails({int productId}) async {
    try {
      final response = await client.query(
        QueryOptions(document: gql(queries.getProductDetails(productId))),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['getProductDetails']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await client.query(
        QueryOptions(
          document: gql(queries.getProducts()),
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }
      
      final data = jsonEncode(response.data['getProducts']);
      List<Product> decoded = await jsonDecode(data).map<Product>(
        (product) => Product.fromJson(product)
      ).toList();

      return decoded;
      
    } catch (e) {
      print('error');
      print(e);
      rethrow;

    }
  }

  @override
  Future<bool> changeProductDetails({Product product}) async {
    try {
      final response = await client.query(
        QueryOptions(
          document: gql(
            queries.editProductDetails(
              product.id, 
              product.name,
              product.description, 
              product.isTaxable, 
              product.photoLink
            ),
          ),
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['changeProductDetails']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

    @override
  Future<bool> addVariant({NewVariant variant, int productId}) async {
      try {
      final response = await client.query(
        QueryOptions(
          document: gql(
            queries.addVariant(
              variant.name, 
              variant.quantity, 
              variant.price, 
              productId
            )
          ),
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['addVariant']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteAllVariants({int productId}) async {
    try {
      final response = await client.query(
        QueryOptions(
          document: gql(
            queries.deleteAllVariants(productId),
          ),
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['deleteAllVariants']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteVariant({int productVariantId}) async {
    try {
      final response = await client.query(
        QueryOptions(
          document: gql(
            queries.deleteVariant(productVariantId),
          ),
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['deleteVariant']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> editVariant({ProductVariant variant}) async {
    try {
      final response = await client.query(
        QueryOptions(
          document: gql(
            queries.editVariant(variant.variantName, variant.quantity,
                variant.price, variant.variantId),
          ),
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['editVariant']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }
}
