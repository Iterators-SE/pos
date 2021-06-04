import '../../database/local/local_database.dart';
import 'transaction_datasource.dart';

class TransactionLocalDataSource implements ITransactionLocalDataSource {
  TransactionLocalDataSource({this.local});
  final AppDatabase local;

  @override
  Future<void> cacheTransactions(dynamic data) async{
    final List<Transaction> transactions = data.map((transaction){
      return Transaction(id: transaction.id);
    });
    await transactions.map(local.addTransaction);
  }
  
  @override
  Future<Transaction> getTransaction({int id}) async{
    return await local.getTransaction(id);
  }

  @override
  Future<List<Transaction>> getTransactions() async{
    return await local.getTransactions();
  }

  @override
  Future<void> cacheTransaction(dynamic data)async {
    final Transaction transaction = data.map((transaction){
      return Transaction(id: transaction.id);
    });
    await local.addTransaction(transaction);
  }
}
