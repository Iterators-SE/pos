import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/product.dart';
import '../../repositories/transactions/interval.dart';
import 'transaction_datasource.dart';

class TransactionLocalDataSource implements ITransactionDataSource {
    TransactionLocalDataSource({this.client, this.storage});

  final GraphQLClient client;
  final SharedPreferences storage; // TODO: Swap with Moor or

  @override
  Future<List> getAllProductBreakdowns({Interval interval = Interval.day}) {
    // TODO: implement getAllProductBreakdowns
    throw UnimplementedError();
  }

  @override
  Future getGenericBreakdown() {
    // TODO: implement getGenericBreakdown
    throw UnimplementedError();
  }

  @override
  Future getProductBreakdown({int id}) {
    // TODO: implement getProductBreakdown
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getTopThree({Interval interval = Interval.day}) {
    // TODO: implement getTopThree
    throw UnimplementedError();
  }

}