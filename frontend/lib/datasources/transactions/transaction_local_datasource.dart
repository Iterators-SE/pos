import '../../database/local/local_database.dart';
import 'transaction_datasource.dart';

class TransactionLocalDataSource implements ITransactionLocalDataSource {
  TransactionLocalDataSource({this.local});

  final AppDatabase local;

  @override
  Future<void> cacheTransactions(dynamic data) {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheTransaction(dynamic data) {
    throw UnimplementedError();
  }

  @override
  Future<Transaction> getTransaction({int id}) {
    return local.getTransaction(id);
  }

  @override
  Future<List<Transaction>> getTransactions() {
    return local.getTransactions();
  }
}
