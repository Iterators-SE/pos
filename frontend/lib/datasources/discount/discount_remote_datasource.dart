import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/discounts.dart';
import 'discount_datasource.dart';
import 'discount_local_datasource.dart';

class DiscountRemoteDataSource implements IDiscountRemoteDataSource {
  final DiscountLocalDataSource local;
  final SharedPreferences storage;
  GraphQLClient client;

  DiscountRemoteDataSource(
      {@required this.client, @required this.local, @required this.storage});

  @override
  Future<Discount> getDiscount({@required int id}) async {
    try {
      final query = r'''
        query getDiscount($id : Number!) {
          action: getDiscount(id: $id) {
            id,
            description,
            percentage,
            products {
              id
            }
            inclusiveDates,
            startTime,
            endTime
          }
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          fetchPolicy: FetchPolicy.networkOnly,
          variables: {
            'id': id,
          },
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['action']);
      // await local.cacheDiscounts(data);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Discount>> getDiscounts() async {
    try {
      final query = r'''
        query {
          getDiscounts {
            id,
            description,
            percentage,
            products {
              id
            }
            inclusiveDates,
            startTime,
            endTime
          }
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          fetchPolicy: FetchPolicy.networkOnly
          )
        );

      print(response);

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonDecode(jsonEncode(response.data['getDiscounts']));
      ("Data: $data");
      // if ((await local.getDiscounts()).isEmpty) {
      //   await local.cacheDiscounts(data);
      //   print(await local.getDiscounts());
      // }

      var discounts = <Discount>[];

      for (var i = 0; i < data.length; i++) {
        discounts.add(Discount.fromJson(data[i]));
      }
      return discounts;
    } catch (e) {
      print(e);
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
          action: createGenericDiscount(input: $input) {
            id,
            description,
            percentage,
            products {
              id
            }
          }
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          fetchPolicy: FetchPolicy.networkOnly,
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
      return Discount.fromJson(jsonDecode(data));
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
          action: createCustomDiscount(input: $input, custom: $custom) {
            id,
            description,
            percentage,
            products {
              id
            }
            inclusiveDates,
            startTime,
            endTime
          }
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          fetchPolicy: FetchPolicy.networkOnly,
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
      return Discount.fromJson(jsonDecode(data));
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
          action: updateGenericDiscount(id: $id, input: $input) {
            id,
            description,
            percentage,
            products {
              id
            }
          }
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          fetchPolicy: FetchPolicy.networkOnly,
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
      return Discount.fromJson(jsonDecode(data));
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
          fetchPolicy: FetchPolicy.networkOnly,
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
      return Discount.fromJson(jsonDecode(data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteDiscount({@required int id}) async {
    try {
      // TODO: Fix Discount and make nullable
      final query = '''
        mutation  {
          deleteDiscount(id: $id) {
            products {
              id
            }
          }
        }''';

      final response = await client.mutate(
        MutationOptions(
          document: gql(query),
          fetchPolicy: FetchPolicy.networkOnly
        ),
      );

      print(response);

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['deleteDiscount']);
      print(data);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
