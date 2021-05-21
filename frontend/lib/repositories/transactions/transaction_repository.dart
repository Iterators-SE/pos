import 'package:either_option/either_option.dart';
import 'package:meta/meta.dart';

import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../datasources/transactions/transaction_datasource.dart';
import '../../models/order.dart';
import '../../models/transaction.dart';

abstract class ITransactionRepository {
  final ITransactionRemoteDataSource remote;
  final ITransactionLocalDataSource local;
  final NetworkInfo network;

  const ITransactionRepository({
    @required this.remote,
    @required this.local,
    @required this.network,
  });

  Future<Either<Failure, List<Transaction>>> getTransactions();
  Future<Either<Failure, Transaction>> getTransaction({@required int id});
  Future<Either<Failure, Transaction>> createTransaction(List<Order> orders);
}
