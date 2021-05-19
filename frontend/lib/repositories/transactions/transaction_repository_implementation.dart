import 'package:either_option/either_option.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../datasources/transactions/transaction_local_datasource.dart';
import '../../datasources/transactions/transaction_remote_datasource.dart';
import '../../models/product.dart';
import 'interval.dart';
import 'local_fetch_case.dart';
import 'transaction_repository.dart';

// TODO: add actual queries
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
  Future<Either<Failure, List>> getAllProductBreakdowns({
    Interval interval = Interval.day,
  }) async {
    if (await network.isConnected) {
      try {
        final data = await remote.getAllProductBreakdowns(interval: interval);
        // local.cache();
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
        final data = await local.getAllProductBreakdowns(interval: interval);
        return Right(data);
      } on CacheException {
        return Left(CacheFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    }
  }

  @override
  Future<Either<Failure, dynamic>> getGenericBreakdown() async {
    if (await network.isConnected) {
      try {
        final data = await remote.getGenericBreakdown();
        // local.cache();
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
        final data = await local.getGenericBreakdown();
        return Right(data);
      } on CacheException {
        return Left(CacheFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    }
  }

  @override
  Future<Either<Failure, dynamic>> getProductBreakdown({int id}) async {
    if (await network.isConnected) {
      try {
        final data = await remote.getProductBreakdown(id: id);
        // local.cache();
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
        final data = await local.getProductBreakdown(id: id);
        return Right(data);
      } on CacheException {
        return Left(CacheFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getTopThree({
    Interval interval = Interval.day,
  }) async {
    if (await network.isConnected) {
      try {
        final data = await remote.getTopThree(interval: interval);
        // local.cache();
        return Right(data);
      } on OperationException catch (e) {
        List<Product> data =
            await fetchFromLocal(LocalFetch.getTopThree)(interval);

            // double check if this is best way to handle this error
        if (data.isNotEmpty) {
          return Right(data);
        }

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
        List<Product> data =
            await fetchFromLocal(LocalFetch.getTopThree)(interval);
        return Right(data);
      } on CacheException {
        return Left(CacheFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    }
  }

  @override
  Function fetchFromLocal(LocalFetch fetchCase) {
    switch (fetchCase) {
      case LocalFetch.getAllProductBreakdowns:
        return local.getAllProductBreakdowns;
        break;
      case LocalFetch.getGenericBreakdown:
        return local.getGenericBreakdown;
        break;
      case LocalFetch.getProductBreakdown:
        return local.getProductBreakdown;
        break;
      case LocalFetch.getTopThree:
        return local.getTopThree;
        break;
      default:
        return local.getAllProductBreakdowns;
    }
  }
}
