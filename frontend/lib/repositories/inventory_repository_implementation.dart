import 'package:either_option/either_option.dart';
import 'package:graphql/client.dart';

import '../core/error/exception.dart';
import '../core/error/failure.dart';
import '../datasources/inventory/inventory_datasource.dart';
import '../models/product.dart';
import 'inventory_repository.dart';

class InventoryRepository implements IInventoryRepository {
  final IInventoryDataSource remote;

  InventoryRepository({this.remote});

  @override
  Future<Either<Failure, bool>> addProduct(
      {String productname,
      String description,
      bool taxable,
      String photoLink}) async {
    try {
      final data = await remote.addProduct(
          productname: productname,
          description: description,
          taxable: taxable,
          photoLink: photoLink);
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
  Future<Either<Failure, bool>> deleteProduct({int productId}) async {
    try {
      final data = await remote.deleteProduct(productId: productId);
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
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final data = await remote.getProducts();
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
  Future<Either<Failure, Product>> getProductDetails({int productId}) async {
    try {
      final data = await remote.getProductDetails(productId: productId);
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
