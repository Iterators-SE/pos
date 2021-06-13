import 'dart:convert';

import 'package:graphql/client.dart';

import '../../models/order.dart';
import '../../models/transaction.dart';
import 'transaction_datasource.dart';

class TransactionRemoteDataSource implements ITransactionRemoteDataSource {
  TransactionRemoteDataSource({this.client});

  GraphQLClient client;

  @override
  Future<Transaction> createTransaction({List<Order> orders}) async {
    try {
      final query = r'''
        mutation createTransaction($orders: OrderInput){
          action: createTransaction(orders: $orders)
        }''';

      final productIds = orders.map((e) => e.product.id).toList();
      final variantIds = orders.map((e) => e.variant.variantId).toList();
      final quantity = orders.map((e) => e.quantity).toList();

      final response = await client.mutate(
        MutationOptions(
          document: gql(query),
          variables: {
            'orders': {
              'productIds': productIds,
              'variantIds': variantIds,
              'quantity': quantity
            },
          },
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonDecode(jsonEncode(response.data["action"])) as Map;
      return Transaction.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Transaction> getTransaction({int id}) async {
    try {
      final query = r'''
        query getTransaction($id: number){
          action: getTransaction(id: $id)
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {'id': id},
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonDecode(jsonEncode(response.data["action"])) as Map;
      return Transaction.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    try {
      final query = r'''
        query getTransactions(){
          action: getTransactions()
        }''';

      final response = await client.query(
        QueryOptions(document: gql(query)),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonDecode(jsonEncode(response.data["action"])) as List<Map>;
      return data.map((e) => Transaction.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
