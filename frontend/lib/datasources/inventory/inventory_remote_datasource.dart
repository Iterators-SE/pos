import 'dart:convert';

// ignore: unused_import
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/product.dart';
import 'inventory_datasource.dart';

class InventoryRemoteDataSource implements InventoryDataSource {
  InventoryRemoteDataSource({this.client, this.storage});

  // final _userProducts = 'USER_PRODUCTS';
  final GraphQLClient client;
  final SharedPreferences storage;

  @override
  Future<bool> addProduct(
      {String productname,
      String description,
      bool taxable,
      String photoLink}) async {
    try {
      final query = r'''
        mutation addProduct($productname: String!, $description: String!, $taxable: bool!, $photoLink: String!) {
          action: addProduct(productname: $productname, description: $description, taxable: $taxable, photolink: $photoLink)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {
            'productname': productname,
            'description': description,
            'taxable': taxable,
            'photolink': photoLink
          },
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
      final query = r'''
        mutation deleteProduct($productId: Number!) {
          action: addProduct(productId: $productname)
        }''';

      final response = await client.query(
        QueryOptions(document: gql(query), variables: {'productId': productId}),
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
      final query = r'''
        mutation deleteProduct($productId: Number!) {
          action: addProduct(productId: $productname)
        }''';

      final response = await client.query(
        QueryOptions(document: gql(query), variables: {'productId': productId}),
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
      final query = "";

      final response = await client.query(
        QueryOptions(
          document: gql(query),
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
}
