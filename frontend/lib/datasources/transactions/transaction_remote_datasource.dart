import 'dart:convert';

import 'package:graphql/client.dart';

import '../../models/order.dart';
// import '../../models/product.dart';
// import '../../models/product_variant.dart';
import '../../models/transaction.dart';
import 'transaction_datasource.dart';

class TransactionRemoteDataSource implements ITransactionRemoteDataSource {
  TransactionRemoteDataSource({this.client});

  GraphQLClient client;

  // @override
  // Future<Transaction> createTransaction({List<Order> orders}) async {
  //   try {
  //     final query = r'''
  //       mutation createTransaction($orders: OrderInput){
  //         action: createTransaction(orders: $orders)
  //       }''';

  //     final productIds = orders.map((e) => e.product.id).toList();
  //     final variantIds = orders.map((e) => e.variant.variantId).toList();
  //     final quantity = orders.map((e) => e.quantity).toList();

  //     final response = await client.mutate(
  //       MutationOptions(
  //         document: gql(query),
  //         variables: {
  //           'orders': {
  //             'productIds': productIds,
  //             'variantIds': variantIds,
  //             'quantity': quantity
  //           },
  //         },
  //       ),
  //     );

  //     if (response.hasException) {
  //       throw response.exception;
  //     }

  //     final data = jsonDecode(jsonEncode(response.data["action"])) as Map;
  //     return Transaction.fromJson(data);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<Transaction> createTransaction({List<Order> orders}) async {
    try {
      final productIds = orders.map((e) => e.product.id).toList();
      final variantIds = orders.map((e) => e.variant.variantId).toList();
      final quantity = orders.map((e) => e.quantity).toList();

      final query = '''
      mutation {
        createTransaction(orders:{
          productIds: $productIds,
          variantIds: $variantIds,
          quantity: $quantity
        }){
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

      final response = await client.mutate(
        MutationOptions(
            document: gql(query), fetchPolicy: FetchPolicy.networkOnly),
      );

      if (response.hasException) {
        throw response.exception;
      }

      print(response);

      final data = jsonDecode(jsonEncode(response.data["createTransaction"]));

      // print(data['id'].runtimeType);
      // print(data['orders'][0]['id'].runtimeType);
      // print(data["orders"][0].runtimeType);
      // var x = Order.fromJson(data["orders"][0]);
      // print(x.id);
      // print(x.product);
      // print(x.variant);
      // print(x.quantity);

      // var orders = data["orders"]
      //.map((order) => Order.fromJson(order)).toList();
      // print(orders);

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
      // final query = '''
      //   query getTransactions(){
      //     action: getTransactions {
      //       id
      //       orders {
      //         id
      //         product {
      //           id
      //           name
      //           description
      //           photoLink
      //           isTaxable
      //         }
      //         variant {
      //           id
      //           name
      //           price
      //           quantity
      //         }
      //         quantity
      //       }
      //       createdAt
      //     }
      //   }''';

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

      // List listOfTransactions = jsonDecode(data);

      // DUMMY DATA
      // var transactions =
//  <Transaction>[
//       Transaction(
//         id: 1,
//         orders: [
//           Order(
//             id: 1,
//             product:
//                 Product(id: 1, name: "Kopi", description: "Best KOPI"),
//             variant: ProductVariant(
//               variantId: 1,
//               productId: 1,
//               variantName: 'Small',
//               quantity: 400,
//               price: 100,
//             ),
//             quantity: 3,
//           ),
//           Order(
//             id: 1,
//             product:
//                 Product(id: 1, name: "Kopi", description: "Best KOPI"),
//             variant: ProductVariant(
//               variantId: 2,
//               productId: 1,
//               variantName: 'Small',
//               quantity: 200,
//               price: 160,
//             ),
//             quantity: 5,
//           )
//         ],
//         createdAt: DateTime.now(),
//       )
//     ] ??
      // listOfTransactions
      //         ?.map((transaction) => Transaction.fromJson(transaction))
      //         ?.toList() ??
      //     <Transaction>[];

      // print('transactions');
      // print(transactions);
      return transactions;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
