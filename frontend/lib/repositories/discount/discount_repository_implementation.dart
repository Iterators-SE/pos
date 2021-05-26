import 'package:either_option/either_option.dart';
import 'package:meta/meta.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../datasources/discount/discount_datasource.dart';
import '../../models/discounts.dart';
import 'discount_repository.dart';

class DiscountRepository implements IDiscountRepository {
  final DiscountDataSource remote;

  DiscountRepository({@required this.remote});

  @override
  Future<Either<Failure, Discount>> getDiscount({@required int id}) async {
    try {
      final data = await remote.getDiscount(id: id);
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

  @override
  Future<Either<Failure, List<Discount>>> getDiscounts() async {
    try {
      final data = await remote.getDiscounts();
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

  @override
  Future<Either<Failure, bool>> createGenericDiscount({
    @required String description,
    @required int percentage,
    @required List<int> products,
  }) async {
    try {
      final data = await remote.createGenericDiscount(
          description: description, percentage: percentage, products: products);
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

  @override
  Future<Either<Failure, Discount>> createCustomDiscount({
    @required String description,
    @required int percentage,
    @required List<int> products,
    @required DateTime endDate,
    @required DateTime startDate,
    @required String endTime,
    @required String startTime,
  }) async {
    try {
      final data = await remote.createCustomDiscount(
        description: description,
        percentage: percentage,
        products: products,
        endDate: endDate,
        startDate: startDate,
        endTime: endTime,
        startTime: startTime,
      );

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

  @override
  Future<Either<Failure, Discount>> updateGenericDiscount({
    @required int id,
    @required String description,
    @required int percentage,
    @required List<int> products,
  }) async {
    try {
      final data = await remote.updateGenericDiscount(
        id: id,
        description: description,
        percentage: percentage,
        products: products,
      );

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

  @override
  Future<Either<Failure, Discount>> updateCustomDiscount({
    @required int id,
    @required String description,
    @required int percentage,
    @required List<int> products,
    @required DateTime endDate,
    @required DateTime startDate,
    @required String endTime,
    @required String startTime,
  }) async {
    try {
      final data = await remote.updateCustomDiscount(
        id: id,
        description: description,
        percentage: percentage,
        products: products,
        endDate: endDate,
        startDate: startDate,
        endTime: endTime,
        startTime: startTime,
      );

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

  Future<Either<Failure, bool>> deleteDiscount({@required int id}) async {
    try {
      final data = await remote.deleteDiscount(id: id);
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
}
