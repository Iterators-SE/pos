import 'package:either_option/either_option.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../datasources/transactions/transaction_local_datasource.dart';
import '../../datasources/transactions/transaction_remote_datasource.dart';
import '../../models/order.dart';
import '../../models/transaction.dart';
import 'transaction_repository.dart';

class TransactionRepository implements ITransactionRepository {
  final TransactionRemoteDataSource remote;
  final TransactionLocalDataSource local;
  final NetworkInfo network;

  TransactionRepository({
    @required this.remote,
    @required this.local,
    @required this.network,
  });

  @override
  Future<Either<Failure, dynamic>> getTransaction({int id}) async {
    if (await network.isConnected()) {
      try {
        final data = await remote.getTransaction(id: id);
        await local.cacheTransaction(data);
        return Right(data);
      } on OperationException catch (e) {
        return Left(OperationFailure(e.graphqlErrors.first.message));
      } on NoResultsFoundException {
        return Left(NoResultsFoundFailure());
      } on Exception {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    } else {
      try {
        final data = await local.getTransaction(id: id);
        return Right(data);
      } on CacheException {
        return Left(CacheFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Transaction>> createTransaction(
      List<Order> orders, {String link}) async {
    if (await network.isConnected()) {
      try {
        final data = await remote.createTransaction(orders: orders, link: link);
        return Right(data);
      } on OperationException catch (e) {
        return Left(OperationFailure(e.graphqlErrors.first.message));
      } on NoResultsFoundException {
        return Left(NoResultsFoundFailure());
      } on Exception {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    }

    return Left(UnhandledFailure());
  }

  @override
  Future<Either<Failure, List<dynamic>>> getTransactions() async {
    if (await network.isConnected()) {
      try {
        final data = await remote.getTransactions();
        // await local.cacheTransactions(data);
        return Right(data);
      } on OperationException catch (e) {
        return Left(OperationFailure(e.graphqlErrors.first.message));
      } on NoResultsFoundException {
        return Left(NoResultsFoundFailure());
      } on Exception {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    } else {
      try {
        final data = await local.getTransactions();
        return Right(data);
      } on CacheException {
        return Left(CacheFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    }
  }
}
