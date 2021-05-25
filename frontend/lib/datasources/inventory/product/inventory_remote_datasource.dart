import 'dart:convert';

import 'package:graphql/client.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../../../models/product.dart';
import 'inventory_datasource.dart';

class InventoryRemoteDataSource implements IInventoryDataSource {
  InventoryRemoteDataSource({this.graphQLConfig, this.queries});

  final GraphQLConfiguration graphQLConfig;
  final MutationQuery queries;

  @override
  Future<int> addProduct({
    String productName,
    String description,
    bool isTaxable,
    String photoLink,
  }) async {
    try {
      final response = await graphQLConfig.clientToQuery().query(
            QueryOptions(
              document: gql(
                queries.addProducts(
                    productName, description, isTaxable, photoLink),
              ),
            ),
          );
      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['addProducts']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteProduct({int productId}) async {
    try {
      final response = await graphQLConfig.clientToQuery().query(
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
      final response = await graphQLConfig.clientToQuery().query(
            QueryOptions(document: gql(queries.getProductDetails(productId))),
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
  Future<List<Product>> getProducts() async {
    try {
      final response = await graphQLConfig.clientToQuery().query(
            QueryOptions(
              document: gql(queries.getProducts()),
            ),
          );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['getProducts']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> changeProductDetails(
      {int productId,
      String productName,
      String description,
      bool isTaxable,
      String photoLink}) async {
    try {
      final response = await graphQLConfig.clientToQuery().query(
            QueryOptions(
              document: gql(
                queries.editProductDetails(
                    productId, productName, description, isTaxable, photoLink),
              ),
            ),
          );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['editProductDetails']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }
}
