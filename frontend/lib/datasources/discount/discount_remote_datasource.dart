import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/discounts.dart';
import 'discount_datasource.dart';

class DiscountRemoteDataSource implements DiscountDataSource {
  DiscountRemoteDataSource({@required this.client, @required this.storage});

  final GraphQLClient client;
  final SharedPreferences storage;

  @override
  Future<Discount> getDiscount({@required int id}) async {
    try {
      final query = r'''
        query getDiscount($id : Number!) {
          action: getDiscount(id: $id)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {
            'id': id,
          },
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['action']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Discount>> getDiscounts() async {
    try {
      final query = r'''
        query getDiscounts() {
          action: getDiscounts()
        }''';

      final response = await client.query(QueryOptions(document: gql(query)));

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['action']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Discount> createGenericDiscount({
    @required String description,
    @required int percentage,
    @required List<int> products,
  }) async {
    try {
      final query = r'''
        mutation createGenericDiscount($input: DiscountInput!) {
          action: createGenericDiscount(input: $input)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {
            'input': {
              'description': description,
              'percentage': percentage,
              'products': products
            }
          },
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['action']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Discount> createCustomDiscount({
    @required String description,
    @required int percentage,
    @required List<int> products,
    @required DateTime endDate,
    @required DateTime startDate,
    @required String endTime,
    @required String startTime,
  }) async {
    try {
      final query = r'''
          mutation createCustomDiscount($input: DiscountInput!, $custom: CustomDiscountInput) {
          action: createCustomDiscount(input: $input, custom: $custom)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {
            'input': {
              'description': description,
              'percentage': percentage,
              'products': products,
            },
            'custom': {
              'endTime': endTime,
              'startTime': startTime,
              'inclusiveDates': [
                startDate.toUtc().toString().split(' ')[0],
                endDate.toUtc().toString().split(' ')[0]
              ]
            }
          },
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['action']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Discount> updateGenericDiscount({
    @required int id,
    @required String description,
    @required int percentage,
    @required List<int> products,
  }) async {
    try {
      final query = r'''
        mutation updateGenericDiscount($id: Number!, $input: DiscountInput!) {
          action: updateGenericDiscount(id: $id, input: $input)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {
            'id': id,
            'input': {
              'description': description,
              'percentage': percentage,
              'products': products
            }
          },
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['action']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Discount> updateCustomDiscount({
    @required int id,
    @required String description,
    @required int percentage,
    @required List<int> products,
    @required DateTime endDate,
    @required DateTime startDate,
    @required String endTime,
    @required String startTime,
  }) async {
    try {
      final query = r'''
          mutation updateCustomDiscount($id: Number!, $input: DiscountInput!, $custom: CustomDiscountInput) {
          action: updateCustomDiscount(id: $id, input: $input, custom: $custom)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {
            'id': id,
            'input': {
              'description': description,
              'percentage': percentage,
              'products': products,
            },
            'custom': {
              'endTime': endTime,
              'startTime': startTime,
              'inclusiveDates': [
                startDate.toUtc().toString().split(' ')[0],
                endDate.toUtc().toString().split(' ')[0]
              ]
            }
          },
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['action']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteDiscount({@required int id}) async {
    try {
      final query = r'''
        mutation deleteDiscount($id: Number!) {
          action: deleteDiscount(id: $id)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {
            'id': id,
          },
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['action']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }
}
