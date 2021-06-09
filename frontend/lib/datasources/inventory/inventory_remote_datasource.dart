import 'dart:convert';

import 'package:graphql/client.dart';

import '../../features/inventory/models/new_product.dart';
import '../../features/inventory/models/new_variant.dart';
import '../../graphql/queries.dart';
import '../../models/product.dart';
import '../../models/product_variant.dart';
import 'inventory_datasource.dart';
import 'inventory_local_datasource.dart';

class InventoryRemoteDataSource implements IInventoryRemoteDataSource {
  InventoryRemoteDataSource({this.client, this.queries, this.local});

  final InventoryLocalDataSource local;
  GraphQLClient client;
  final MutationQuery queries;

  @override
  Future<bool> addProduct({NewProduct product}) async {
    try {
      final responseProduct = await client.query(
        QueryOptions(
          document: gql(
            queries.addProduct(product.name, product.description,
                product.isTaxable, product.photoLink),
          ),
        ),
      );

      var data = responseProduct.data['addProduct'];
      var productId = await int.parse(data['id']);

      var result;

      for (final variant in product.variants) {
        result = await client.query(
          QueryOptions(
            document: gql(queries.addVariant(
                variant.name, variant.quantity, variant.price, productId)),
          ),
        );
      }
      return await result.data['addVariant'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteProduct({int productId}) async {
    try {
      final responseVariants = await client.query(
        QueryOptions(
          document: gql(
            queries.deleteAllVariants(productId),
          ),
        ),
      );

      // print(responseVariants.data['deleteAllVariants']);
      if (responseVariants.hasException) {
        throw responseVariants.exception;
      }

      final responseProduct = await client.query(
        QueryOptions(
          document: gql(queries.deleteProduct(productId)),
        ),
      );

      if (responseProduct.hasException) {
        throw responseProduct.exception;
      }

      final data = responseProduct.data['deleteProduct'];
      // print(await "deleteproduct");
      // print(await data);
      return data;
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

      var data = jsonEncode(response.data['getProductDetails']);
      return Product.fromJson(jsonDecode(data));
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

      var data = jsonEncode(response.data['getProducts']);
      data = jsonDecode(data);

      if (data == null) {
        return [];
      }

      List<Product> decoded =  jsonDecode(data)
          .map<Product>((product) => Product.fromJson(product))
          .toList();
      return decoded;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> changeProductDetails({Product product}) async {
    try {
      final response = await client.query(
        QueryOptions(
          document: gql(
            queries.changeProductDetails(product.id, product.name,
                product.description, product.isTaxable, product.photoLink),
          ),
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = response.data['changeProductDetails'];
      return data;
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
                variant.name, variant.quantity, variant.price, productId),
          ),
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = response.data['addVariant'];
      return data;
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

      final data = response.data['deleteAllVariants'];
      print(await data);
      return data;
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

      final data = response.data['deleteVariant'];
      return data;
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

      final data = response.data['editVariant'];
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
