import 'package:meta/meta.dart';

import '../../models/order.dart';
import '../../models/transaction.dart';

abstract class ITransactionDataSource {
  Future<List<Transaction>> getTransactions();
  Future<Transaction> getTransaction({@required int id});
}

abstract class ITransactionRemoteDataSource implements ITransactionDataSource {
  Future<Transaction> createTransaction({@required List<Order> orders});
}

abstract class ITransactionLocalDataSource implements ITransactionDataSource {
  Future<void> cacheTransactions(dynamic data);
  Future<void> cacheTransaction(dynamic data);
}
