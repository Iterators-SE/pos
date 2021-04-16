import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/product.dart';
import 'inventory_datasource.dart';

class InventoryRemoteDataSource implements IInventoryDataSource {
  InventoryRemoteDataSource({this.client, this.storage});

  final GraphQLClient client;
  final SharedPreferences storage;

  @override
  Future<bool> addProduct(
      {String productName,
      String description,
      bool isTaxable,
      String photoLink}) async {
    try {
      final query = r'''
        mutation addProduct($productname: String!, $description: String!, $taxable: bool!, $photoLink: String!) {
          action: addProduct(productname: $productname, description: $description, taxable: $isTaxable, photolink: $photoLink)
        }''';

      final response =
          await client.query(QueryOptions(document: gql(query), variables: {
        'productname': productName,
        'description': description,
        'taxable': isTaxable,
        'photolink': photoLink
      }));

      if (response.hasException) {
        throw response.exception;
      }

      print(response.data);

      final data = jsonEncode(response.data['action']);
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

      final response = await client.query(QueryOptions(document: gql(query)));

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

  @override
  Future<bool> changeProductDetails(
      {int productId,
      String productName,
      String description,
      bool isTaxable,
      String photoLink}) async {
    try {
      final query = r'''
        mutation changeProductDetails($productId: Number!, $data: ChangeProductDetailsInput!) {
          action: changeProductDetails(productId: $productId, data: $data)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {
            'data': {
              'productname': productName,
              'description': description,
              'taxable': isTaxable,
              'photolink': photoLink
            },
            'productId': productId
          },
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      // Can be extracted to a model
      final data = jsonEncode(response.data['changeProductDetails']);
      return jsonDecode(data); // or data.toLowerCase() == 'true'
    } catch (e) {
      rethrow;
    }
  }
}
