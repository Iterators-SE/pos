import 'package:shared_preferences/shared_preferences.dart';

import '../../models/transaction.dart';
import 'transaction_datasource.dart';

class TransactionLocalDataSource implements ITransactionLocalDataSource {
  TransactionLocalDataSource({this.storage});

  final SharedPreferences storage; // SWAP W/ MOOR

  @override
  Future<void> cacheTransactions(dynamic data) {
    // TODO: implement cacheTransactions
    throw UnimplementedError();
  }

  @override
  Future<void> cacheTransaction(dynamic data) {
    // TODO: implement cacheTransactions
    throw UnimplementedError();
  }

  @override
  Future<Transaction> getTransaction({int id}) {
    // TODO: implement getTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getTransactions() {
    // TODO: implement getTransactions
    throw UnimplementedError();
  }
}
