import 'package:either_option/either_option.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../datasources/tax/tax_local_datasource.dart';
import '../../datasources/tax/tax_remote_datasource.dart';
import '../../features/tax/models/new_tax.dart';
import '../../models/tax.dart';
import 'tax_repository.dart';

class TaxRepository implements ITaxRepository {
  final TaxRemoteDataSource remote;
  final TaxLocalDataSource local;
  final NetworkInfo network;

  TaxRepository(
      {@required this.remote, @required this.local, @required this.network});

  @override
  Future<Either<Failure, bool>> addTax(NewTax newTax) async {
    if (true) {
      try {
        final data = await remote.addTax(newTax);
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

    // return Left(UnhandledFailure());
  }
  
    @override
    Future<Either<Failure, bool>> deleteTax(Tax tax) async {
      if (true) {
        try {
          final data = await remote.deleteTax(tax);
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

      // return Left(UnhandledFailure());
    }
  
    @override
    Future<Either<Failure, bool>> editTax(Tax tax) async {
      if (true) {
        try {
          final data = await remote.editTax(tax);
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

      // return Left(UnhandledFailure());
    }
  
    @override
    Future<Either<Failure, Tax>> getSelectedTax() async {
      if (true) {
        try {
          final data = await remote.getSelectedTax();
          // await local.cacheSelectedTax(data);
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

      // return Left(UnhandledFailure());
    }
  
    @override
    Future<Either<Failure, Tax>> getTaxDetails(int taxId) async {
      if (true) {
        try {
          final data = await remote.getTaxDetails(taxId);
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

      // return Left(UnhandledFailure());
    }
  
    @override
    Future<Either<Failure, List<Tax>>> getTaxes() async {
      if (true) {
        try {
          final data = await remote.getTaxes();
          // await local.cacheTaxes(data);
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

      // return Left(UnhandledFailure());
    }
  
    @override
    Future<Either<Failure, bool>> selectTax(Tax tax) async {
      if (true) {
        try {
          final data = await remote.selectTax(tax);
          // await local.cacheTaxes(data);
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

      // return Left(UnhandledFailure());
  }
}
