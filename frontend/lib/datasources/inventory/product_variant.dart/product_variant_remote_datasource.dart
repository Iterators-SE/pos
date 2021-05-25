import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/product_variant.dart';
import 'product_variant_datasource.dart';

class ProductVariantRemoteDataSource implements ProductVariantDataSource {
  ProductVariantRemoteDataSource({this.client, this.storage});

  final GraphQLClient client;
  final SharedPreferences storage;

  // TODO: Should this be `.data['...'] or `.data['action']
  @override
  Future<bool> addVariant(
      {String variantName, int price, int quantity, int productID}) async {
    try {
      final query = r'''
      mutation addVariant($variantname: String!, $price: int!, $quantity: int!){
        action: addVariant(variantname: $variantname, price: $price, quantity: $quantity)
      }
      ''';

      final response = await client.query(QueryOptions(
          document: gql(query),
          variables: {
            'variantname': variantName,
            'price': price,
            'quantity': quantity
          }));
      if (response.hasException) {
        throw response.exception;
      }
      final data = jsonEncode(response.data['addvariant']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteVariant({int id}) async {
    try {
      final query = r'''
        mutation removeVariant($variantid: Number!) {
          action: removeVariant(variantid: $variantid)
        }''';

      final response = await client.query(
        QueryOptions(document: gql(query), variables: {'variantid': id}),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['removeVariant']);
      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductVariant>> getVariants({int productid}) async {
    try {
      final query = r'''
      ''';
      final response = await client.query(QueryOptions(
          document: gql(query), variables: {'productid': productid}));
      if (response.hasException) {
        throw response.exception;
      }
      final data = jsonEncode(response.data["getVariants"]);

      return jsonDecode(data);
    } catch (e) {
      rethrow;
    }
  }
}
