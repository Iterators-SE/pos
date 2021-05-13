import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/discounts.dart';
import 'discounts_datasource.dart';

class DiscountRemoteDataSource implements DiscountDataSource {
  DiscountRemoteDataSource({this.client, this.storage});

  final GraphQLClient client;
  final SharedPreferences storage;

  @override
  Future<bool> addDiscount({
    String description,
    int percentage,
    String products,
    String createdAt,
    String updatedAt,
  }) async {
    try {
      final query = r'''
        mutation addDiscount($description: String!, $percentage: int!, $products: String!, $createdAt: String!, $updatedAt: String!) {
          action: addProduct(description: $desc, percentage: percent, products: product, createdAt: dateCreated, updatedAt: dateUpdated)
        }''';

      final response =
          await client.query(QueryOptions(document: gql(query), variables: {
        'description': description,
        'percentage': percentage,
        'products': products,
        'cretedAt': createdAt,
        'updatedAt': updatedAt
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
  Future<bool> deleteDiscount({int id}) async {
    try {
      final query = r'''
        mutation deleteDiscount($discountId: Number!) {
          action: addProduct(discountId: $description)
        }''';

      final response = await client.query(QueryOptions(document: gql(query)));

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['deleteDiscount']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Discounts>> getDiscount({int discountId}) async {
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

      final data = jsonEncode(response.data['getDiscount']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }
}
