import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../../features/tax/models/new_tax.dart';
import '../../models/tax.dart';
import 'tax_datasource.dart';

class TaxRemoteDataSource implements ITaxRemoteDataSource {
  TaxRemoteDataSource({this.client});

  GraphQLClient client;

  @override
  Future<bool> addTax(NewTax newTax) async {
    try {
      final query = """
        mutation{
          addTax(percentage: ${newTax.percentage}, name: "${newTax.name}")
        }
      """;

      final response = await client.query(
        QueryOptions(document: gql(query)),
      );

      if (response.hasException) {
        throw response.exception;
      }

      return response.data['addTax'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteTax(Tax tax) async {
    try {
      final query = """
        mutation {
          deleteTax(taxId: ${tax.id})
        }
      """;

      final response = await client.query(
        QueryOptions(document: gql(query)),
      );

      if (response.hasException) {
        throw response.exception;
      }

      return response.data['deleteTax'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> editTax(Tax tax) async {
    try {
      var query = """
      mutation {
        editTax(
          taxId: ${tax.id}, data: {
          name: "${tax.name}",
          percentage: ${tax.percentage}   
        })
      }
        """;

      final response = await client.query(QueryOptions(document: gql(query)));

      if (response.hasException) {
        throw response.exception;
      }

      return response.data['editTax'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Tax> getSelectedTax() async {
    try {
      final query = '''
        query {
          getSelectedTax{
            id,
            name,
            isSelected,
            percentage,
          }
        }
        ''';

      final response = await client.query(
        QueryOptions(document: gql(query)),
      );

      // print(await response);

      if (response.hasException) {
        throw response.exception;
      }

      var data = jsonEncode(response.data['getSelectedTax']);
      return Tax.fromJson(jsonDecode(data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Tax> getTaxDetails(int taxId) async {
    try {
      final query = """
        query {
          getTaxDetails(taxId: $taxId){
            id,
            name,
            isSelected,
            percentage,
          }
        }
      """;

      final response = await client.query(
        QueryOptions(document: gql(query)),
      );

      if (response.hasException) {
        throw response.exception;
      }

      var data = jsonEncode(response.data['getTaxDetails']);
      return Tax.fromJson(jsonDecode(data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Tax>> getTaxes() async {
    try {
      final query = """
        query {
          getTaxes{
            id,
            name,
            isSelected,
            percentage
          }
        }
      """;

      final response = await client.query(
        QueryOptions(document: gql(query)),
      );

      if (response.hasException) {
        throw response.exception;
      }

      final data = jsonEncode(response.data['getTaxes']);
      List<Tax> decoded = await jsonDecode(data)
          .map<Tax>((product) => Tax.fromJson(product))
          .toList();

      return decoded;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> selectTax(Tax tax) async {
    try {
      final query = '''
        mutation {
         selectTax(taxId: ${tax.id})
        }''';

      final response = await client.query(
        QueryOptions(
          document: gql(query),
        ),
      );

      // final response = await client.query(
      //   QueryOptions(document: gql(query)),
      // );

      await print(response);

      if (response.hasException) {
        throw response.exception;
      }
      // print(response.data['selectTax']);
      return response.data['selectTax'];
    } catch (e) {
      rethrow;
    }
  }
}
