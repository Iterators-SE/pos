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
    Future<Discount> getDiscount({int id}) async {
      try {
        final query = r'''
        query getDiscount($id : Number!) {
          action: getDiscount(id: $id)
        }''';

        final response = await client.query(
          QueryOptions(
            document: gql(query),
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
    Future<List<Discount>> getDiscounts({List<int> id}) async {
      try {
        final query = r'''
        query getDiscounts($id : Number!) {
          action: getDiscount(id: $id)
        }''';

        final response = await client.query(
          QueryOptions(
            document: gql(query),
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
  Future<bool> createGenericDiscount({
    String description,
    int percentage,
    List<int> products,
  }) async {
    try {
      final query = r'''
        mutation createGenericDiscount($input: DiscountInput!) {
          action: createGenericDiscount(input: $input)
        }''';

      final response = await client.query(QueryOptions(
          document: gql(query),
          variables: {
            'description': description,
            'percentage': percentage,
            'products': products
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
  Future<Discount> createCustomDiscount({
    String description,
    int percentage,
    List<int> products,
    DateTime endDate,
    DateTime startDate,
    String endTime,
    String startTime,
    // String inclusiveDates,
  }) async {
    try {
      final query = r'''
          mutation createCustomDiscount($input: DiscountInput!, $custom: CustomDiscountInput) {
          action: createCustomDiscount(input: $input, custom: $custom)
        }''';

      final response =

          await client.query(QueryOptions(document: gql(query), variables: {
        'description': description,
        'percentage': percentage,
        'products': products,
        'endTime': endTime,
        'startTime': startTime,
        'inclusiveDates': [
          startDate.toUtc().toString().split(' ')[0], 
          endDate.toUtc().toString().split(' ')[0]
        ]

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
  Future<Discount> updateGenericDiscount({
    int id,
    String description,
    int percentage,
    List<int> products,
  }) async {
    try {
      final query = r'''
        mutation updateGenericDiscount($id: Number!, $input: DiscountInput!) {
          action: updateGenericDiscount(id: $id, input: $input)
        }''';

      final response = await client.query(
        QueryOptions(document: gql(query), variables: {
            'id': id,
            'description': description,
            'percentage': percentage,
            'products': products
        }),
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
    int id,
    String description,
    int percentage,
    List<int> products,
    DateTime endDate,
    DateTime startDate,
    String endTime,
    String startTime,
    // String inclusiveDates,
  }) async {
    try {
      final query = r'''
          mutation updateCustomDiscount($id: Number!, $input: DiscountInput!, $custom: CustomDiscountInput) {
          action: updateCustomDiscount(id: $id, input: $input, custom: $custom)
        }''';

      final response =
          await client.query(QueryOptions(document: gql(query), variables: {
          'id': id,
          'description': description,
          'percentage': percentage,
          'products': products,
          'endTime': endTime,
          'startTime': startTime,
          'inclusiveDates': [
            startDate.toUtc().toString().split(' ')[0], 
            endDate.toUtc().toString().split(' ')[0]
          ]
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
        mutation deleteDiscount($id: Number!) {
          action: deleteDiscount(id: $id)
        }''';

      final response = await client.query(
        QueryOptions(document: gql(query), variables: {'id': id}),
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
