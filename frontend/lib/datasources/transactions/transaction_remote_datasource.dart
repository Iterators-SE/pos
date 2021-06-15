import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

import '../../models/order.dart';
// import '../../models/product.dart';
// import '../../models/product_variant.dart';
import '../../models/transaction.dart';
import 'transaction_datasource.dart';

class TransactionRemoteDataSource implements ITransactionRemoteDataSource {
  TransactionRemoteDataSource({this.client});

  GraphQLClient client;

  @override
  Future<Transaction> createTransaction(
      {@required List<Order> orders, String link}) async {
    try {
      final productIds = orders.map((e) => e.product.id).toList();
      final variantIds = orders.map((e) => e.variant.variantId).toList();
      final quantity = orders.map((e) => e.quantity).toList();

// TODO: USE THIS MUTATION AFTER UPDATING PROD SERVER
      // final query = '''
      // mutation {
      //   createTransaction(orders:{
      //     productIds: $productIds,
      //     variantIds: $variantIds,
      //     quantity: $quantity
      //   }, link: $link) {
      //     id,
      //     orders {
      //       id,
      //       product{
      //         id,
      //         name,
      //         description,
      //         photoLink,
      //         isTaxable,
      //         variant {
      //           id,
      //           name,
      //           price,
      //           quantity
      //         }
      //       },
      //       variant{
      //         id,
      //         name,
      //         price,
      //         quantity,
      //       },
      //       quantity,
      //     },
      //     createdAt,

      //   }
      // }
      // ''';
      final query = '''
      mutation {
        createTransaction(orders:{
          productIds: $productIds,
          variantIds: $variantIds,
          quantity: $quantity
        }) {
          id,
          orders {
            id,
            product{
              id,
              name,
              description,
              photoLink,
              isTaxable,
              variant {
                id,
                name,
                price,
                quantity
              }
            },
            variant{
              id,
              name,
              price,
              quantity,
            },
            quantity,
          },
          createdAt,
        }
      }
      ''';

      final response = await client.mutate(
        MutationOptions(
            document: gql(query), fetchPolicy: FetchPolicy.networkOnly),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonDecode(jsonEncode(response.data["createTransaction"]));
      return Transaction.fromJson(data);
    } catch (e) {
      print(e);
      print("error!!!!");
      rethrow;
    }
  }

  @override
  Future<Transaction> getTransaction({int id}) async {
    try {
// TODO: USE THIS MUTATION AFTER UPDATING PROD SERVER

      final query = r'''
        query getTransaction($id: number){
          action: getTransaction(id: $id) {
             id,
            orders {
              id,
              product{
                id,
                name,
                description,
                photoLink,
                isTaxable,
                variant {
                  id,
                  name,
                  price,
                  quantity
                }
              },
              variant{
                id,
                name,
                price,
                quantity,
              },
              quantity,
            },
            createdAt,
            }
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
      // TODO: USE AFTER UPDATING PROD SERVER
      // final query = '''
      // query {
      //   getTransactions{
      //     id,
      //     orders{
      //       id,
      //       product{
      //         id,
      //         name,
      //         description,
      //         photoLink,
      //         isTaxable,
      //         variant {
      //           id,
      //           name,
      //           price,
      //           quantity
      //         }
      //       },
      //       variant{
      //         id,
      //         name,
      //         price,
      //         quantity,
      //       },
      //       quantity,
      //     },
      //     createdAt,
      //     link
      //   }
      // } 
      // ''';
            final query = '''
      query {
        getTransactions{
          id,
          orders{
            id,
            product{
              id,
              name,
              description,
              photoLink,
              isTaxable,
              variant {
                id,
                name,
                price,
                quantity
              }
            },
            variant{
              id,
              name,
              price,
              quantity,
            },
            quantity,
          },
          createdAt,
        }
      } 
      ''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (response.hasException) {
        throw response.exception;
      }

      var transactions = <Transaction>[];
      final data = jsonDecode(jsonEncode(response.data["getTransactions"]));

      for (var i = 0; i < data.length; i++) {
        transactions.add(Transaction.fromJson(data[i]));
      }

      return transactions;
    } catch (e) {
      rethrow;
    }
  }
}
