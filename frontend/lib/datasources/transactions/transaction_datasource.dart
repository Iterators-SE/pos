import 'package:meta/meta.dart';

import '../../models/order.dart';
import '../../models/transaction.dart';

abstract class ITransactionDataSource {
  dynamic getTransactions();
  dynamic getTransaction({@required int id});
}

abstract class ITransactionRemoteDataSource implements ITransactionDataSource {
  Future<Transaction> createTransaction(
      {@required List<Order> orders, String link});
}

abstract class ITransactionLocalDataSource implements ITransactionDataSource {
  Future<void> cacheTransactions(dynamic data);
  Future<void> cacheTransaction(dynamic data);
}
