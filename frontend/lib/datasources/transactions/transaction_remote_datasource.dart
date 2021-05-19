import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/product.dart';
import '../../repositories/transactions/interval.dart';
import 'transaction_datasource.dart';

class TransactionRemoteDataSource implements ITransactionDataSource {
  TransactionRemoteDataSource({this.client, this.storage});

  final GraphQLClient client;
  final SharedPreferences storage; // TODO: Remove or swap

  @override
  Future<List> getAllProductBreakdowns(
      {Interval interval = Interval.day}) async {
    try {
      final query = r'''
        query getAllProductBreakdowns($data: SignupInput!){
          action: getAllProductBreakdowns(data: $data)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {
            'data': {
              "interval": interval.toString().split('.')[1].toUpperCase()
            }
          },
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data["action"]);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

// HOW DOES THIS WORK?
  @override
  Future getGenericBreakdown() async {
    try {
      final query = r'''
        query getGenericBreakdown($data: SignupInput!){
          action: getGenericBreakdown(data: $data)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data["action"]);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getProductBreakdown({int id}) async {
    try {
      final query = r'''
        query getProductBreakdown($data: SignupInput!){
          action: getProductBreakdown(data: $data)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {
            'data': {
              "id": id
            }
          },
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data["action"]);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> getTopThree({Interval interval = Interval.day}) async {
    try {
      final query = r'''
        query getTopThree($data: SignupInput!){
          action: getTopThree(data: $data)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {
            'data': {
              "interval": interval.toString().split('.')[1].toUpperCase()
            }
          },
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data["action"]);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }
}
